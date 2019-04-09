
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

	void GetFitnesses(int (*populaatio)[genesize], int* fitness){

        int i, j;
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


	int onkoListassa(int *rankIndex, int checkedElement, int filledIndexes)
	{
        int listassa = 0;
        int i;
        for(i = 0; i < filledIndexes; i++)
        {
            if( checkedElement == rankIndex[i])
                listassa = 1;
        }
        return listassa;
	}

    //TO DO: CrossOver
    //DONE: Rank determination
	void CrossOver(int (*populaatio)[genesize], int *fitnesses)
	{
	    int best;
        int rankIndex[popsize];
        int i,j,k,tmp;

        for (i = 0; i < popsize; i++)
        {
            best = -1;
            for (j = 0; j < popsize; j++)
            {
                if(!onkoListassa(rankIndex,j,i))
                {

                    if (fitnesses[j] > best)
                    {
                        rankIndex[i] = j;
                        best = fitnesses[j];
                    }
                }
            }
        }

        for(i = 0; i< popsize;i++)
        {
            printf("rankindex = %d \n", rankIndex[i]);
        }

	}



	int main() {

        srand(time(NULL));
		//int populaatio[popsize][genesize];
		int populaatio[popsize][genesize];

		luoPopulaatio(populaatio);

		tulostaPopulaatio(populaatio);

		int fitness[popsize];
        int i;
        for(i = 0; i < popsize; i++){
            fitness[i] = 0;
        }
        //printf("Fitness = %d", fitness[1]);
		GetFitnesses(populaatio, fitness);

		for(i = 0; i< popsize; i++){
            printf("Fitness = %d\n", fitness[i]);
		}
		//printf("Fitness = %d", fitness[1]);
        CrossOver(populaatio,fitness);

	}
