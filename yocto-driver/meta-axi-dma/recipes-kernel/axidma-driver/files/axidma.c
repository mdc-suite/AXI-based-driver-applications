#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/io.h>
#include <linux/dma-mapping.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/uaccess.h>
#include <linux/delay.h>
#include <linux/of.h>
#include <linux/clk.h>           
#include <linux/err.h>           
#include <linux/string.h>
#include <linux/of_address.h>


// #define IMAGE_WIDTH 88
// #define IMAGE_HEIGHT 142
// #define IMAGE_SIZE (IMAGE_HEIGHT*IMAGE_WIDTH)
// #define IMAGE_DATA_SIZE (IMAGE_SIZE*4)
// #define DMA_BUF_SIZE  IMAGE_SIZE


// #define DEVICE_NAME "my_dma_chrdev"

#define DMA_REG_SIZE  0x10000
#define DMA_BUF_SIZE  65535

#define S2MM_DMACR   0x30
#define S2MM_DMASR   0x34
#define S2MM_SA      0x48
#define S2MM_LENGTH  0x58

#define MM2S_DMACR   0x00
#define MM2S_DMASR   0x04
#define MM2S_SA      0x18
#define MM2S_LENGTH  0x28

// #define ACC_BASE_ADDR  0xB0000000
// #define ACC_SIZE 0x10000
// #define ACC_CTR_REG_ADDR_OFFSET 0x00
// #define ACC_GIE_REG_ADDR_OFFSET 0x04 //Global Interrupt Enable Register
// #define ACC_IER_REG_ADDR_OFFSET 0x08 //IP Interrupt Enable Register
// #define ACC_OUT_DATA_REG_ADDR_OFFSET 0x10
// #define ACC_OUT_CTRL_REG_ADDR_OFFSET 0x14
// #define ACC_OUT_DATA_SIZE 0x4

// #define AP_READY_MASK 0x08
// #define AP_START_MASK 0x01
#define DMA_HALTED_MASK 0x01
#define DMA_IDLE_MASK 0x2
#define RESET_DMA 0x4
#define START_DMA 0x1
#define STOP_DMA 0x0

// #define EXPECTED_RESULT 0x28

#define DMA_MAGIC 'D'

#define IOCTL_SELECT_CHANNEL     _IOW(DMA_MAGIC, 0, int)
#define IOCTL_READ_STATUS_REGISTER     _IOR(DMA_MAGIC, 4, unsigned __user int*)
#define IOCTL_DMA_WRITE_BUFFER   _IOW(DMA_MAGIC, 1, unsigned char __user *)
#define IOCTL_DMA_READ_BUFFER    _IOR(DMA_MAGIC, 2, unsigned char __user *)
#define IOCTL_DMA_START_TRANSFER _IOW(DMA_MAGIC, 3, size_t)
#define IOCTL_DMA_RESET _IOW(DMA_MAGIC, 5, size_t)
#define IOCTL_DMA_RESET_ALL _IOW(DMA_MAGIC, 6, size_t)

#define DMA_SYNC_TIMEOUT 10000
#define SYNC_TIMEOUT_ERROR -2

const char MM2S_string[5] = "MM2S";
const char S2MM_string[5] = "S2MM";

struct dma_channel_info {
    struct device_node *node;
    void __iomem *regs;
    void __iomem *dma_virt;
    dma_addr_t dma_phys;
    u32 datawidth;
    u32 device_id;
    size_t dma_size;
    u32 direction; //0 = S2MM, 1 = MM2S
};

struct uniss_dma_dev {
    struct cdev cdev;
    struct device *dev;
    struct dma_channel_info *channels;
    u32 num_channels;
};


static struct class *uniss_class;
static dev_t uniss_dev_t;
static struct uniss_dma_dev *uniss_dev;
static int selected_channel = 0;

int sync_dma_to_idle(void *, int);
int sync_dma_to_halted(void *, int);

int sync_dma_to_idle(void __iomem *regs, int direction){
    int i;
    for(i=0;i<DMA_SYNC_TIMEOUT;i++){
        if((*(unsigned int *)(regs+(direction==0?S2MM_DMASR:MM2S_DMASR))) & DMA_IDLE_MASK){
            return i;
        }
    }

    return SYNC_TIMEOUT_ERROR;

}

int sync_dma_to_halted(void __iomem *regs, int direction){
int i;
    for(i=0;i<DMA_SYNC_TIMEOUT;i++){
        if((*(unsigned int *)(regs+(direction==0?S2MM_DMASR:MM2S_DMASR))) & DMA_HALTED_MASK){
            return i;
        }
    }

    return SYNC_TIMEOUT_ERROR;

}

//File operations start here

static int uniss_open(struct inode *inode, struct file *filp)
{
    struct uniss_dma_dev *ud = container_of(inode->i_cdev, struct uniss_dma_dev, cdev);
    filp->private_data = ud;
    return 0;
}

static long uniss_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
    struct uniss_dma_dev *ud = file->private_data;

    size_t len;

    unsigned int val;

    if (selected_channel >= ud->num_channels || selected_channel < 0)
        selected_channel = 0;
 
    void __iomem *dma_virt = ud->channels[selected_channel].dma_virt;
    void __iomem *regs = ud->channels[selected_channel].regs;
    dma_addr_t dma_phys = ud->channels[selected_channel].dma_phys;
    u32 direction = ud->channels[selected_channel].direction;

    switch (cmd) {
        int i;
        case IOCTL_SELECT_CHANNEL:
            if (arg >= ud->num_channels|| selected_channel < 0) {
                pr_err("Invalid DMA channel selected\n");
                return -EINVAL;
            }
            selected_channel = (int)arg;
            pr_info("DMA channel set to %d\n", selected_channel);
            break;
        case IOCTL_READ_STATUS_REGISTER:
            printk("entering read status function\n");
            if(selected_channel >= ud->num_channels || selected_channel < 0){
                pr_err("Invalid DMA channel selected\n");
                return -EINVAL;
            }
            printk("reading...\n");

            val = ioread32(regs + (direction ? MM2S_DMASR : S2MM_DMASR));

             if (copy_to_user((u32 __user *)arg, &val, sizeof(val)))
                return -EFAULT;

            printk("read status\n");
            break;
        case IOCTL_DMA_WRITE_BUFFER:
            if(selected_channel >= ud->num_channels || selected_channel < 0){
                pr_err("Invalid DMA channel selected\n");
                return -EINVAL;
            }
            if (ud->channels[selected_channel].direction != 1 /* MM2S */ ) {
                pr_err("Cannot write buffer: channel is not MM2S\n");
                return -EINVAL;
            }


            if (copy_from_user(dma_virt, (unsigned char __user *)arg, DMA_BUF_SIZE)) {
                pr_err("Failed to copy data from user\n");
                return -EFAULT;
            }
            pr_info("Data copied to DMA buffer (MM2S)\n");
            break;

        case IOCTL_DMA_READ_BUFFER:
            if(selected_channel >= ud->num_channels || selected_channel < 0){
                pr_err("Invalid DMA channel selected\n");
                return -EINVAL;
            }
            if (ud->channels[selected_channel].direction != 0 /* S2MM */ ) {
                pr_err("Cannot read buffer: channel is not S2MM\n");
                return -EINVAL;
            }


            if (copy_to_user((unsigned char __user *)arg, dma_virt, DMA_BUF_SIZE)) {
                pr_err("Failed to copy data to user\n");
                return -EFAULT;
            }
            pr_info("Data copied from DMA buffer (S2MM)\n");
            break;

        case IOCTL_DMA_START_TRANSFER:
            if(selected_channel >= ud->num_channels || selected_channel < 0){
                pr_err("Invalid DMA channel selected\n");
                return -EINVAL;
            }

            len = (size_t)arg;
            if (len > DMA_BUF_SIZE) {
                pr_err("Transfer length exceeds buffer size\n");
                return -EINVAL;
            }

            

            if (direction == 1 /* MM2S */ ) {
                pr_info("Starting MM2S DMA transfer of length %zu\n", len);
                
                printk("Channel %d: test read from dma status reg: 0x%x\n",selected_channel, *(unsigned int *)(regs+MM2S_DMASR));

                if(!(*(unsigned int *)(regs+MM2S_DMASR) & DMA_HALTED_MASK)){
                    printk("Channel %d: Syncing DMA...\n",selected_channel);
                    
                    int res = sync_dma_to_halted(regs,(int)direction);

                    if(res==SYNC_TIMEOUT_ERROR){
                        printk("Channel %d: Sync timeout error\n", selected_channel);
                        return SYNC_TIMEOUT_ERROR;
                    }
                    else{
                        printk("Channel %d: Sync done in %d iterations\n",selected_channel,res);
                    }
                }

                iowrite32(START_DMA,regs+MM2S_DMACR); 
                printk("Channel %d: test read from dma ctrl reg after enable: 0x%08x\n",selected_channel,ioread32(regs+MM2S_DMACR));
                printk("Channel %d: test read from dma status reg after enable: 0x%08x\n",selected_channel,ioread32(regs+MM2S_DMASR));

                iowrite32(dma_phys,regs+MM2S_SA);

                printk("Channel %d: test read from dma source address reg after write: 0x%08x\n",selected_channel,ioread32(regs+MM2S_SA));
                
                iowrite32(len,regs+MM2S_LENGTH);

                printk("Channel %d: test read from dma transfer length reg after write: 0x%08x\n",selected_channel,ioread32(regs+MM2S_LENGTH));               
                
            } else if (direction == 0 /* S2MM */ ) {
                pr_info("Starting S2MM DMA transfer of length %zu\n", len);

                
                
                printk("Channel %d: test read from dma status reg: 0x%x\n",selected_channel, *(unsigned int *)(regs+S2MM_DMASR));

                if(!(*(unsigned int *)(regs+S2MM_DMASR) & DMA_HALTED_MASK)){
                    printk("Channel %d: Syncing DMA...\n",selected_channel);
                    
                    int res = sync_dma_to_halted(regs,(int)direction);

                    if(res==SYNC_TIMEOUT_ERROR){
                        printk("Channel %d: Sync timeout error\n", selected_channel);
                        return SYNC_TIMEOUT_ERROR;
                    }
                    else{
                        printk("Channel %d: Sync done in %d iterations\n",selected_channel,res);
                    }
                }

                iowrite32(START_DMA,regs+S2MM_DMACR); 
                printk("Channel %d: test read from dma ctrl reg after enable: 0x%08x\n",selected_channel,ioread32(regs+S2MM_DMACR));
                printk("Channel %d: test read from dma status reg after enable: 0x%08x\n",selected_channel,ioread32(regs+S2MM_DMASR));

                iowrite32(dma_phys,regs+S2MM_SA);

                printk("Channel %d: test read from dma source address reg after write: 0x%08x\n",selected_channel,ioread32(regs+S2MM_SA));
                
                iowrite32(len,regs+S2MM_LENGTH);

                printk("Channel %d: test read from dma transfer length reg after write: 0x%08x\n",selected_channel,ioread32(regs+S2MM_LENGTH));

            } else {
                pr_err("Invalid DMA transfer direction selected\n");
                return -EINVAL;
            }

            break;
        case IOCTL_DMA_RESET:
            if (selected_channel >= ud->num_channels|| selected_channel < 0) {
                pr_err("Invalid DMA channel selected\n");
                return -EINVAL;
            }
            printk("Resetting DMA...");
            iowrite32(RESET_DMA,regs+(direction?MM2S_DMACR:S2MM_DMACR));
            printk("Channel %d: DMA Reset successfully\n",selected_channel);
            break;
        case IOCTL_DMA_RESET_ALL:
            printk("Resetting all DMAs...\n");
            
            for(i=0; i<ud->num_channels;i++){
                iowrite32(RESET_DMA,ud->channels[i].regs+(ud->channels[i].direction?MM2S_DMACR:S2MM_DMACR));
            }
            printk("All DMAs have been reset.\n");
            break;
        default:
            return -ENOTTY;
    }

    return 0;
}

static const struct file_operations uniss_fops = {
    .owner = THIS_MODULE,
    .open = uniss_open,
    .unlocked_ioctl = uniss_ioctl,
};

//File operations end here

static int uniss_dmas_probe(struct platform_device *pdev)
{
    struct device *dev = &pdev->dev;
    struct device_node *np = dev->of_node;
    struct device_node *dma_np;
    struct device_node *chan_np;
    struct dma_channel_info *channels;
    int count, i, chan_count = 0;

    
    printk("Probing DMAs...\n");
    printk("Setting mask...\n");

    if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
        dev_err(&pdev->dev, "32-bit DMA not supported\n");
        printk("32-bit DMA not supported\n");
        return -EIO;
    }

    count = of_count_phandle_with_args(np, "dev-handles", NULL);
    if (count <= 0) {
        dev_err(dev, "No dev-handles found\n");
        printk("No dev-handles found\n");
        return -EINVAL;
    }

    printk("Found %d DMA devices\n", count);

    channels = devm_kzalloc(dev, sizeof(*channels) * (count + 1), GFP_KERNEL);
    if (!channels)
        return -ENOMEM;

    printk("Parsing dev-handles...\n");
    
    void __iomem *controller_regs;
    
    for (i = 0; i < count; i++) {
        dma_np = of_parse_phandle(np, "dev-handles", i);
        if (!dma_np) {
            dev_warn(dev, "Failed to parse dev-handles[%d]\n", i);
            printk("Failed to parse dev-handles[%d]\n", i);
            continue;
        }

        // Iterate over children (channels)

        controller_regs = NULL;

        for_each_child_of_node(dma_np, chan_np) {
            u32 mm2s;

            if (of_property_read_u32(chan_np, "mm2s", &mm2s))
                continue;

            // if (mm2s != 1)
            //     continue;  // We only care about MM2S (TX) channels

            // Optional: read other properties
            of_property_read_u32(chan_np, "xlnx,datawidth", &channels[chan_count].datawidth);
            of_property_read_u32(chan_np, "xlnx,device-id", &channels[chan_count].device_id);

            // Map registers if needed — optional: use parent
            channels[chan_count].node = chan_np;

            if (!controller_regs) {
                controller_regs = of_iomap(dma_np, 0);
                if (!controller_regs) {
                    dev_err(dev, "Failed to map DMA controller registers\n");
                    printk("Failed to map DMA controller registers\n");
                    continue;
                }
            }

            channels[chan_count].regs = controller_regs;

            channels[chan_count].direction = mm2s;

            printk("Found %s channel... Channel %d: datawidth=%u device-id=%u\n",
                     mm2s?MM2S_string:S2MM_string,
                     chan_count,
                     channels[chan_count].datawidth,
                     channels[chan_count].device_id);

            printk("Allocating memory for channel %d...\n",chan_count);
            channels[chan_count].dma_size = DMA_BUF_SIZE;
            channels[chan_count].dma_virt = dma_alloc_coherent(dev,
                channels[chan_count].dma_size,
                &channels[chan_count].dma_phys,
                GFP_KERNEL);
            
            if (!channels[chan_count].dma_virt) {
                dev_err(dev, "Failed to allocate DMA buffer for channel %d\n", chan_count);
                printk("Failed to allocate DMA buffer for channel %d\n", chan_count);
                iounmap(channels[chan_count].regs); // Rollback what we can
                channels[chan_count].regs = NULL;
                continue;
            }

            printk("DMA buffer allocated for channel %d: virt=%p, phys=%pad, size=%zu\n",
                   chan_count,
                   channels[chan_count].dma_virt,
                   &channels[chan_count].dma_phys,
                   channels[chan_count].dma_size);
            chan_count++;
        }

        of_node_put(dma_np);  // drop reference
    }

    printk("Total channels probed: %d\n", chan_count);

    // You can now store `channels[]` somewhere or attach to driver data

    uniss_dev = devm_kzalloc(dev, sizeof(*uniss_dev), GFP_KERNEL);
    uniss_dev->channels = channels;
    uniss_dev->num_channels = chan_count;
    uniss_dev->dev = dev;

    alloc_chrdev_region(&uniss_dev_t, 0, 1, "uniss_dma");
    cdev_init(&uniss_dev->cdev, &uniss_fops);
    cdev_add(&uniss_dev->cdev, uniss_dev_t, 1);
    uniss_class = class_create(THIS_MODULE,"uniss_dma");
    device_create(uniss_class, NULL, uniss_dev_t, NULL, "uniss_dma");

    platform_set_drvdata(pdev, uniss_dev);
    
    
    return 0;
}

static int uniss_dmas_remove(struct platform_device *pdev)
{
    printk("Removing DMAs...\n");
    struct uniss_dma_dev *ud = platform_get_drvdata(pdev);

    
    struct dma_channel_info *channels = ud->channels;
    int i;

    if (!channels)
        return 0;

    for (i = 0; channels[i].node; i++) {
        if (channels[i].regs)
            iounmap(channels[i].regs);  // Unmap any mapped register regions

        if (channels[i].dma_virt)
            dma_free_coherent(&pdev->dev,
                          channels[i].dma_size,
                          channels[i].dma_virt,
                          channels[i].dma_phys);

        // of_node_put is not needed for child nodes if not retained
        // but if you called of_node_get() elsewhere, release here
    }


    printk("DMAs removed successfully.\n");
    
    device_destroy(uniss_class, uniss_dev_t);
    class_destroy(uniss_class);
    cdev_del(&ud->cdev);
    unregister_chrdev_region(uniss_dev_t, 1);
    
    printk("Character device removed successfully.\n");

    return 0;
}

static const struct of_device_id uniss_dmas_of_match[] = {
    { .compatible = "uniss,dmas" },
    { /* sentinel */ }
};

MODULE_DEVICE_TABLE(of, uniss_dmas_of_match);

static struct platform_driver uniss_dmas_driver = {
    .probe  = uniss_dmas_probe,
    .remove = uniss_dmas_remove,
    .driver = {
        .name = "uniss-dmas",
        .of_match_table = uniss_dmas_of_match,
    },
};

module_platform_driver(uniss_dmas_driver);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Giuseppe Satta");
MODULE_DESCRIPTION("DMA aggregator probing TX channels via dev-handles");
