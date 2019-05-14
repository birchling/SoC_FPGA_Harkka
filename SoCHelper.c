#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include "SoCHelper.h"






uint32_t bool_array_to_32_bit_int(int chromosome_array[32]){
    uint32_t packed_chromosome = 0;
    int i;
    uint32_t mask = 1;
    for(i = 0; i < 32; i++){
        packed_chromosome |= (chromosome_array[i] * mask);
        mask <<= 1;
    }
    return packed_chromosome;
}

void uint32_t_to_bool_array(uint32_t packed_chromosome, int* chromosome_array){
    uint32_t mask = 1;
    int i;
    for(i = 0; i < 32; i++){
        if(packed_chromosome & mask)
            chromosome_array[i] = 1;
        else
        {
            chromosome_array[i] = 0;
        }
        mask <<= 1;
    }



}
