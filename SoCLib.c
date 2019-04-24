#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include "SoCLib.h"

// Pointer to light weight bridge
void *lw_map;

// Pointers to write area in memory
volatile unsigned int* write_mem[WRITE_WORDS];

// Pointers to read area in memory
volatile unsigned int* read_mem[READ_WORDS];
int isInit;
int memory;

// Initialize the memory mapped registers
void SoC_init(void)
{
  int i; // For loops
  isInit = 0;
  memory = EXIT_FAILURE;
  off_t lw_base = LWHPS2FPGA_BRIDGE_BASE;
  // Open the memory device file 
  memory = open("/dev/mem", O_RDWR|O_SYNC);
  if (memory < 0)
    {
      perror("open");
      exit(EXIT_FAILURE);
    }
  
  // Map the lw bridge into process memory
  lw_map = mmap(NULL, PAGE_SIZE, PROT_WRITE | PROT_READ, 
		MAP_SHARED, memory, lw_base);
  if (lw_map == MAP_FAILED)
    {
      perror("mmap");
      close(memory);
      return;
    }
  
  // Get the write AMMS peripheral's base address to different 32-bit words
  for(i=0; i<WRITE_WORDS; i++)
    {
      write_mem[i] = (unsigned int *) (lw_map + WRITE_OFFSET_0 + i*4);
    }
  
  // Get the read AMMS peripheral's base address  to different 32-bit words
  for(i=0; i<READ_WORDS; i++)
    {
      read_mem[i] = (unsigned int *) (lw_map + READ_OFFSET_0 + i*4);
    }
  
  isInit = 1;
  printf("Initialization of memory mapping was SUCCESSFULL \n");
  close(memory);
  return;
}

void SoC_stop(void)
{
  close(memory);
  isInit = 0;
  printf("Memory mapping was CLOSED \n");
  return;
}

// Write input (value) to word (variable index) input_word
void SoC_write(int input, int input_word) // Return output
{
  if(isInit == 0)
    {
      printf("Memory was NOT MAPPED. Call first: void init(void) \n");
      return;
    }
  
  // Write the input value to AMMS
  *write_mem[input_word] = input;
  
  return;
}

// Read output from word (variable index) output_word
int SoC_read(int output_word) // Return output
{
  int ret = 0;
  if(isInit == 0)
    {
      printf("Memory was NOT MAPPED. Call first: void init(void) \n");
      return ret;
    }
  
  // Read the output value from AMMS
  //printf("Luetaan uusi arvo FPGA:sta \n");
  ret = *read_mem[output_word];
  
  return ret;
}

int SoC_writeAndRead(int input, int input_word, int output_word) // Return output
{
  int ret = 0;
  if(isInit == 0)
    {
      printf("Memory was NOT MAPPED. Call first: void init(void) \n");
      return ret;
    }
  
  // Write the input value to AMMS
  //printf("Kirjoitetaan C:ssa FPGA:han arvo: %d\n", input);
  *write_mem[input_word] = input;
  
  // Read the output value from AMMS
  //printf("Luetaan uusi arvo FPGA:sta \n");
  ret = *read_mem[output_word];
  
  //printf("C luki FPGA:sta arvon: %d\n", ret);
  
  return ret;
}
