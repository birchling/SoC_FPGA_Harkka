//#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include "SoCLib.h"
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


void FPGA_Fitness(int (*populaatio)[genesize], int* fitness)
    {
        int temp;
        int i,j;
        int status; // 1 = ongoing, 2 = ready

        for(i = 0; i<popsize; i = i + 3)
        {
            // Writes to FPGA
            for(j = 0; j<3; j++)
            {
                temp = bool_array_to_32_bit_int(populaatio[i+j]);
                SoC_write(temp,j);
            }

            //Write status 1 to FPGA
            SoC_write(1,3);

            //Check FPGA status
            do{
                status = SoC_read(3);
            }
            while(status != 2);

            // Reads from FPGA and saves the values to fitness array
            for(j = 0; j<3; j++)
            {
                fitness[i+j] = SoC_read(j);
            }
        }


    }
}
