#ifndef OURHEAD_H_INCLUDED
#define OURHEAD_H_INCLUDED

#define popsize 45
#define genesize 32
#define maxgen 1000

extern int* createKromosomi();
extern void tulostaKromosomi(int kromo[]);
extern void tulostaPopulaatio(int (*populaatio)[genesize]);
extern void luoPopulaatio(int (*populaatio)[genesize]);
extern void mutaatio(int (*populaatio)[genesize],int mutationrate);
extern void GetFitnesses(int (*populaatio)[genesize], int* fitness);
extern int isInList(int *rankIndex, int checkedElement, int filledIndexes);
extern void CrossOver(int (*populaatio)[genesize], int *fitnesses);
extern int getBestFitness(int *fitness);
extern int getBestIndex(int *fitness);
extern void FPGA_Fitness(int (*populaatio)[genesize], int* fitness);

#endif // OURHEAD_H_INCLUDED
