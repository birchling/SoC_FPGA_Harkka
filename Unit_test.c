#include <stdio.h>
#include "ARM_to_FPGA.h"


int main(){
    //Test Array is correctly transforemed into single unsigned int
    int test_array[32] = {0};
    int i;
    test_array[7] = 1;
    test_array[15] = 1;
    test_array[23] = 1;
    test_array[31] = 1;
    uint32_t test_value = 0x80808080;
    
    if(bool_array_to_32_bit_int(test_array) == test_value){
        printf("TEST: bool_array_to_32_bit_int: Passed\n");
    }
    else{
         printf("TEST: bool_array_to_32_bit_int: Failed\n");
    }

    //Test unsigned int is converted back into array
    int test_result = 1;
    int test_result_array[32] = {0};
    uint32_t_to_bool_array(test_value, test_result_array);
    for(i = 0; i < 32; i++){
        if(test_result_array[i] != test_array[i])
            test_result = 0;
    }

    if(test_result){
        printf("TEST: uint_to_bool_array: Passed\n");
    }
    else{
         printf("TEST: uint_to_bool_array: Failed\n");
    }
    return 0;
}