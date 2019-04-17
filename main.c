
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>

#define popsize 10
#define genesize 10
#define maxgen 10

typedef struct{
    int populaatio[popsize][genesize];
    int fitness;
    int fittest_individual;

} generaatio;
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
		for (i = 0; i < genesize; i++)
		{
			//int a*;
			Sleep(1);
			temp = createKromosomi();
			for(j = 0; j < popsize; j++){
                populaatio[j][i] = temp[j];
			}
		}
	}

	//Mutaation ohjelman pätkä joka toimii... EHKÄ
	//Mutaatio rate pitää olla välillä 0-99%
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
		int best;
		int i;
		best = -1;
		for(i = 0; i < popsize; i++){
			if(best < fitness[i]){
				best = fitness[i];
				if(best == genesize){
					return best;
				}
			}
		}
		return best;
	}



	int main() {
		int best = -1;
		int maxGenerations = 100;
		int fitness[popsize];
		int i;

        srand(time(NULL));
		//int populaatio[popsize][genesize];
		int populaatio[popsize][genesize];

		luoPopulaatio(populaatio);
		int generation = 0;
		do{
			GetFitnesses(populaatio, fitness);
			CrossOver(populaatio,fitness);
			best = getBestFitness(fitness);
			if(best == genesize){
				printf("Best possible answer found\n");
				break;
			}
			/*else if(best > genesize){
				printf("Something went wrong\n");
				break;
			}*/
			else{
				printf("Fitness of best individual = %d\n", best);
				printf("Generation %d completed\n", generation);
			}
			generation++;
		}while(generation < maxGenerations);

		tulostaPopulaatio(populaatio);

        
        
        //printf("Fitness = %d", fitness[1]);
		GetFitnesses(populaatio, fitness);

		for(i = 0; i< popsize; i++){
            printf("Fitness = %d\n", fitness[i]);
		}
		//printf("Fitness = %d", fitness[1]);
	}
