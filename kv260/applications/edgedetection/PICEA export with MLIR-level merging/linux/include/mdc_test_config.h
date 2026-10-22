/* Generated from CoprocessorSpec; do not edit. */
#ifndef MDC_TEST_CONFIG_H
#define MDC_TEST_CONFIG_H
#include <stdint.h>

#define MDC_TEST_DEVICE "/dev/mdc_accel0"
#define MDC_TEST_CHANNELS 3u
#define MDC_TEST_OUTPUTS 1u
#define MDC_TEST_MODE_COUNT 2u
#define MDC_TEST_BUFFER_BYTES 65536u
#define MDC_TEST_CONTROL_OFFSET 0u
#define MDC_TEST_MODE_SHIFT 24u
#define MDC_TEST_COUNTER_CLEAR_BIT 2u
#define MDC_TEST_START_BIT 0u

struct mdc_test_port {
    const char *name;
    unsigned channel;
    unsigned direction;
    unsigned token_bits;
    unsigned register_offset;
};

struct mdc_test_mode { unsigned id; const char *name; };

static const struct mdc_test_port mdc_test_ports[MDC_TEST_CHANNELS] = {
    {"in0", 0u, 1u, 6u, 0u},
    {"in1", 1u, 1u, 8u, 0u},
    {"out0", 2u, 0u, 8u, 4u}
};

static const struct mdc_test_mode mdc_test_modes[MDC_TEST_MODE_COUNT] = {
    {1u, "Roberts"},
    {2u, "Sobel"}
};

static const unsigned int mdc_test_mode_membership_known[MDC_TEST_MODE_COUNT] = {0u, 0u};

static const uint32_t mdc_test_mode_active_masks[MDC_TEST_MODE_COUNT] = {UINT32_C(0xFFFFFFFF), UINT32_C(0xFFFFFFFF)};

#endif
