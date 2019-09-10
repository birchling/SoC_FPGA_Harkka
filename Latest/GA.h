#ifndef OURHEAD_H_INCLUDED
#define OURHEAD_H_INCLUDED

#define popsize 12
#define genesize 32
#define maxgen 100

#include <stdint.h>

extern int* createKromosomi();
extern void tulostaKromosomi(int kromo[]);
extern void tulostaPopulaatio(int (*populaatio)[genesize]);
extern void luoPopulaatio(int (*populaatio)[genesize]);
extern void mutaatio(int (*populaatio)[genesize],int mutationrate);
extern void GetFitnesses(int (*populaatio)[genesize], uint32_t* fitness);
extern int isInList(int *rankIndex, int checkedElement, int filledIndexes);
extern void CrossOver(int (*populaatio)[genesize], uint32_t *fitnesses);
extern int getBestFitness(uint32_t *fitness);
extern int getBestIndex(uint32_t *fitness);
extern void FPGA_Fitness(int (*populaatio)[genesize], uint32_t* fitness);

#endif // OURHEAD_H_INCLUDED
