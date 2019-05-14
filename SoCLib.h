#ifndef SoCLib_h
#define SoCLib_h

#define PAGE_SIZE 4096

// Base address to the lightweight bridge
#define LWHPS2FPGA_BRIDGE_BASE 0xff200000

// Offset to the first 4-byte word (int type) to write to
#define WRITE_OFFSET_0 0x10

// Number of 4-byte words (int type) in write area
#define WRITE_WORDS 4

// Offset to the first 4-byte word (int type) to read from
#define READ_OFFSET_0 0x00

// Number of 4-byte words (int type) in read area
#define READ_WORDS 4

// Pointer to light weight bridge
extern void *lw_map;
extern volatile unsigned int* write_mem[WRITE_WORDS];
extern volatile unsigned int* read_mem[READ_WORDS];

extern void SoC_init(void);
extern void SoC_stop(void);
extern void SoC_write(int input, int input_word);
extern int SoC_read(int output_word);
extern int SoC_writeAndRead(int input, int input_word, int output_word);

#endif
