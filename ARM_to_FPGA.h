#ifndef AMR_TO_FPGA_H
#define AMR_TO_FPGA_H

#include "SoCLib.h"
#include <stdint.h>

uint32_t bool_array_to_32_bit_int(int chromosome_array[32]);
void uint32_t_to_bool_array(uint32_t packed_chromosome, int* chromosome_array);
#endif