#ifndef SOCHELPER_H
#define SOCHELPER_H

#include "SoCLib.h"
#include <stdint.h>
#include "GA.h"


uint32_t bool_array_to_32_bit_int(int chromosome_array[32]);
void uint32_t_to_bool_array(uint32_t packed_chromosome, int* chromosome_array);
extern void FPGA_Fitness(int (*populaatio)[genesize], int* fitness);
#endif
