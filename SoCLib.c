//#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <string.h>
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
  isInit=1;
  printf("Initialization of memory mapping was SUCCESSFULL \n");
  return;
}

void SoC_stop(void)
{
  isInit=0;
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

  return ret;
}

// write len bytes from the input buffer
void SoC_writebuf(char *buf, size_t len) // Return output
{
  int maxbytes=WRITE_WORDS*4;
  if(isInit == 0)
    {
      printf("Memory was NOT MAPPED. Call first: void init(void) \n");
      return;
    }
  if(len>maxbytes)
    {
      printf("Buffer too large. Writing only %d first bytes.\n", maxbytes);
      len=maxbytes;
    }

  // Write the input value to AMMS
  return;
}

// Read len bytes from the output buffer
void SoC_readbuf(char *buf, size_t len) // Return output
{
  int maxbytes=READ_WORDS*4;
  if(isInit == 0)
    {
      printf("Memory was NOT MAPPED. Call first: void init(void) \n");
      return;
    }
  if(len>maxbytes)
    {
      printf("Buffer too large. Reading only %d first bytes.\n", maxbytes);
      len=maxbytes;
    }

  return;
}




int SoC_writeAndRead(int input, int input_word, int output_word) // Return output
{
  int ret = 0;
  if(isInit == 0)
    {
      printf("Memory was NOT MAPPED. Call first: void init(void) \n");
      return ret;
    }

  return ret;
}
