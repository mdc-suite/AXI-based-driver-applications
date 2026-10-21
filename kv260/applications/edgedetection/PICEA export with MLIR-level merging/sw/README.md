# Test on Kria
This folder contains all files to run examples of applications edge detection on Kria KV260.
## Then run the following commands:

```bash
gcc acc_test_edgedetect.c -o  acc_test_edgedetect
sudo fpgautil -R 
sudo fpgautil -b acc_dfgmlir.bit
sudo fpgautil -o pl_acc.dtbo 
sudo ./acc_test_edgedetect roberts input.pgm
sudo ./acc_test_edgedetect sobel input.pgm
```