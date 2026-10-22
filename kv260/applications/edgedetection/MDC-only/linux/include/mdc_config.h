/* Generated from CoprocessorSpec; do not edit. */
#ifndef MDC_CONFIG_H
#define MDC_CONFIG_H
#define MDC_CHANNELS 3u
#define MDC_OUTPUTS 1u
#define MDC_MODES 2u
#define MDC_BUFFER_BYTES 65536u
static const unsigned int mdc_directions[MDC_CHANNELS] = {1, 1, 0};
static const unsigned int mdc_modes[] = {1, 2};
static const unsigned long long mdc_bases[MDC_CHANNELS+1] = {0xa0010000ULL, 0xa0000000ULL, 0xa0100000ULL, 0xa0300000ULL};
#endif
