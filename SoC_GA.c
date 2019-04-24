#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include "SoCLib.h"
#include "ARM_to_FPGA"


int main() {
  printf("Initialize conduit\n");
  SoC_init();

  printf("Begin calculations\n");
  int input[4]={0};
  int output[4]={0};
  for(int i=0; i<10; i++) {
    for(int j=0; j<4; j++) {
      int rvalue = rand()>>24;
      input[j]=rvalue;
      SoC_write(rvalue, j);
    }
    for(int j=0; j<4; j++) {
      output[j]=SoC_read(j);
    }
    printf("Input (%3d, %3d, %3d, %3d) -> output (%3d, %3d, %3d, %3d)\n",
    	   input[0], input[1], input[2], input[3],
    	   output[0], output[1], output[2], output[3]);
    
  }
  printf("Closing the conduit\n");
  SoC_stop();
  printf("The end\n");
}
