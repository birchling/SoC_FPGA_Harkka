#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include "SoCLib.h"
#include "SoCHelper.h"
#include "GA.h"


int main() {
  printf("Initialize conduit\n");
  SoC_init();
  //Example SoCFPGA communication
  /*printf("Begin calculations\n");
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
  */
  //Genetic algorithm
  printf("Start GA\n");
	int best = -1;
	int maxGenerations = 10000;
	uint32_t fitness[popsize];
	int i;

	srand(time(NULL));
	//int populaatio[popsize][genesize];
	uint32_t populaatio[popsize][genesize];

	luoPopulaatio(populaatio);

	int generation = 0;
	while(generation < maxGenerations){
		mutaatio(populaatio, 10);
		GetFitnesses(populaatio, fitness);
		CrossOver(populaatio,fitness);
		GetFitnesses(populaatio, fitness);
		best = getBestFitness(fitness);
		if(best == genesize){
			printf("In generation %d\n", generation);
			printf("Best possible answer found in kromosomi %d\n", getBestIndex(fitness)+1);
			printf("Best = %d\n", best);
			break;
		}
		else if(best > genesize){
			printf("Something went wrong\n");
			break;
		}
		else{
			printf("Fitness of best individual = %d\n", best);
			printf("Generation %d completed\n", generation);
		}
		generation++;
	}

	tulostaPopulaatio(populaatio);

	
	
	//printf("Fitness = %d", fitness[1]);
	//GetFitnesses(populaatio, fitness);

	for(i = 0; i< popsize; i++){
		printf("Fitness #%d = %d\n", i+1, fitness[i]);
	}

  printf("Closing the conduit\n");
  SoC_stop();
  printf("The end\n");
}
