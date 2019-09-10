#include "GA.h"
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <time.h>
#include "SoCLib.h"
#include "SoCHelper.h"


int* createKromosomi() {

	int i;
	static int a[genesize];

	for (i = 0; i < genesize; i++)
	{
		a[i] = rand() % 2; //% 2
	}

	return a;
}

void tulostaKromosomi(int kromo[])
{
	int i;
	for (i = 0; i < genesize; i++)
	{
		printf("%d  ", *(kromo + i));
	}
	printf("\n");
}


void tulostaPopulaatio(int (*populaatio)[genesize])
{
	int i, j;
	for (i = 0; i < popsize; i++)
	{
		printf("Kromosomi %i: ", (i + 1));
		//tulostaKromosomi(populaatio[i]);
		for (j = 0; j < genesize; j++)
		{
			printf("%d ", populaatio[i][j]);
		}
		printf("\n");
	}
}

void luoPopulaatio(int (*populaatio)[genesize])
{
	int i;
	int j;
	int *temp;
	for (i = 0; i < popsize; i++)
	{
		//int a*;
		temp = createKromosomi();
		for(j = 0; j < genesize; j++){
			populaatio[i][j] = temp[j];
		}
	}
}

//Mutaation ohjelman p�tk� joka toimii... EHK�
//Mutaatio rate pit�� olla v�lill� 0-99%
void mutaatio(int (*populaatio)[genesize],int mutationrate)
{
	int i,j;
	for (i = 0; i < popsize; i++)
	{
		for (j = 0; j < genesize; j++)
		{
			if ((rand() % 100) < mutationrate){
				if (populaatio[i][j] == 1){
					populaatio[i][j] = 0;
				}
				else{
					populaatio[i][j] = 1;
				}
			}

		}
	}
}

void GetFitnesses(int (*populaatio)[genesize], uint32_t* fitness){

	int i, j;

	for(i = 0; i < popsize; i++){
		fitness[i] = 0;
	}

	//printf("OG Fitness = %d \n", fitness[2]);
	for (i = 0; i < popsize; i++)
	{
		for (j = 0; j < genesize; j++)
		{
			fitness[i] += populaatio[i][j];
			//printf("Fitness = %d \n", fitness[i]);
		}
	}
}


int isInList(int *rankIndex, int checkedElement, int filledIndexes)
{
	int inList = 0;
	int i;
	for(i = 0; i < filledIndexes; i++)
	{
		if( checkedElement == rankIndex[i])
			inList = 1;
	}
	return inList;
}

//CrossOver operation
//Switches the chromosomes between the best individuals in decending order
void CrossOver(int (*populaatio)[genesize], uint32_t *fitnesses)
{
	int best;
	int rankIndex[popsize];
	int i,j;
	int temp[genesize];
	int startFromFirstElement;
	
	//Determine what is the index of the best idividuals
	//E.G. rankIndex[0] is the best, while rankIndex[genesize - 1] is the worst
	for (i = 0; i < popsize; i++)
	{
		best = -1;
		for (j = 0; j < popsize; j++)
		{
			if(!isInList(rankIndex,j,i))
			{

				if (fitnesses[j] > best)
				{
					rankIndex[i] = j;
					best = fitnesses[j];
				}
			}
		}
	}

	/*for(i = 0; i< popsize;i++)
	{
		printf("rankindex = %d \n", rankIndex[i]);
	}*/
	//Preform crossover on the first half or second half of the chromosomes
	for(i = 0; i < popsize; i += 2){
		printf("debug\n");
		startFromFirstElement = rand() % 2; // SEGFAULTS
		printf("Mode is %d", startFromFirstElement);
		if(startFromFirstElement){
			j = 0;
		}
		else{
			j = genesize/2;
		}
		for(; (j < (genesize/2) && (startFromFirstElement)) || (j < (genesize) && (!startFromFirstElement)); j++){
			temp[j] = populaatio[rankIndex[i]][j];
			populaatio[rankIndex[i]][j] = populaatio[rankIndex[i+1]][j];
			populaatio[rankIndex[i+1]][j] = temp[j];
		}
	}
}

int getBestFitness(uint32_t *fitness){
	int best = -1;
	int i;
	for(i = 0; i < popsize; i++){
		if(best < fitness[i]){
			best = fitness[i];
			if(best == genesize){
				printf("Best found in kromosomi %d\n", i+1);
				return best;
			}
		}
	}
	return best;
}
int getBestIndex(uint32_t *fitness){
	int best = -1;
	int best_index = -1;
	int i;
	for(i = 0; i < popsize; i++){
		if(best < fitness[i]){
			best = fitness[i];
			best_index = i;
			if(best == genesize){
				return i;
			}
		}
	}
	return best_index;
}

void FPGA_Fitness(int (*populaatio)[genesize], uint32_t* fitness)
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
