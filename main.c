
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
#include "SoCLib.h"
#include "SoCHelper.h"






int main() {
	printf("Start GA\n");
	int best = -1;
	int maxGenerations = 10000;
	int fitness[popsize];
	int i;

	srand(time(NULL));
	int populaatio[popsize][genesize];

	luoPopulaatio(populaatio);

    SoC_init();
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
