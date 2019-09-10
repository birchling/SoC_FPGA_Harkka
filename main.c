#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include "SoCLib.h"
#include "GA.h"

int main() {
	printf("Initializing FPGA\n");
	printf("Popsize is: %d", popsize);
	SoC_init();
	printf("Start GA\n");
	int best = -1;
	int maxGenerations = 10000;
	uint32_t fitness[popsize];
	int i;

	srand(314);
	int populaatio[popsize][genesize];

	luoPopulaatio(populaatio);

	int generation = 0;
	while(generation < maxGenerations){
        printf("Loop round: %d", generation);
		mutaatio(populaatio, 10);
		//GetFitnesses(populaatio, fitness);
		FPGA_Fitness(populaatio, fitness);
		CrossOver(populaatio,fitness);
		FPGA_Fitness(populaatio, fitness);
		//GetFitnesses(populaatio, fitness);
		best = getBestFitness(fitness);
		if(best == genesize){
			printf("In generation %d\n", generation);
			printf("Best possible answer found in kromosomi %d\n", getBestIndex(fitness)+1);
			printf("Best = %d\n", best);
			break;
		}
		else if(best > genesize){
			printf("Something went wrong\n");
			printf("Best = %d", best);
			break;
		}
		else{
			printf("Fitness of best individual = %d\n", best);
			printf("Generation %d completed\n", generation);
		}
		generation++;
	}

	tulostaPopulaatio(populaatio);

	SoC_stop();


	//printf("Fitness = %d", fitness[1]);
	//GetFitnesses(populaatio, fitness);

	for(i = 0; i< popsize; i++){
		printf("Fitness #%d = %d\n", i+1, fitness[i]);
	}
	//printf("Fitness = %d", fitness[1]);
}
