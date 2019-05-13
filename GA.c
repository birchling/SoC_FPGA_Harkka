#include "GA.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int* createKromosomi() {

	int i;
	static int a[genesize];

	for (i = 0; i < genesize; i++)
	{
		a[i] = rand() % 2; //% 2
	}
	/*int temp = rand();
	unsigned int mask = 1;
	for (i = 0; i < genesize; i++)
	{
		printf("Temp = %d", temp);
		a[i] = temp & mask;
		if(a[i] > 0){
			a[i] = 1;
		}
		mask = mask << 1;
	}*/

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

void GetFitnesses(int (*populaatio)[genesize], int* fitness){

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
void CrossOver(int (*populaatio)[genesize], int *fitnesses)
{
	int best;
	int rankIndex[popsize];
	int i,j,k, divider;
	int temp[genesize];

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
		int startFromFirstElement = rand() % 2;
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

int getBestFitness(int *fitness){
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
int getBestIndex(int *fitness){
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
