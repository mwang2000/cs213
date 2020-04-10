#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <fcntl.h>
#include <unistd.h>
#include "uthread.h"
#include "uthread_mutex_cond.h"

#ifdef VERBOSE
#define VERBOSE_PRINT(S, ...) printf (S, ##__VA_ARGS__);
#else
#define VERBOSE_PRINT(S, ...) ;
#endif

#define MAX_OCCUPANCY      3
#define NUM_ITERATIONS     100
#define NUM_PEOPLE         20
#define FAIR_WAITING_COUNT 4

/**
 * You might find these declarations useful.
 */
enum Endianness {LITTLE = 0, BIG = 1};
const static enum Endianness oppositeEnd [] = {BIG, LITTLE};

struct Well {
  // TODO
  // condition and mutex threads
  uthread_cond_t endianTypeInWellCond[2];
  uthread_mutex_t mutualExclusionThread;

  // number of people currently in well
  int occupancy;
  
  int occupancyByType[2];

  // number of people waiting, with indices 0 for little and 1 for big.
  int numWaiting[2];

  // number of pople of the other endianness type (than currently in well) waiting
  int numOtherEndWaiting;

  // Enum for type allowed in well currently
  enum Endianness endianTypeInWell;
};

struct Well* createWell() {
  struct Well* Well = malloc (sizeof (struct Well));

  Well->mutualExclusionThread = uthread_mutex_create();
  Well->endianTypeInWellCond[LITTLE] = uthread_cond_create(Well->mutualExclusionThread);
  Well->endianTypeInWellCond[BIG] = uthread_cond_create(Well->mutualExclusionThread);

  Well->occupancy = 0;

  Well->occupancyByType[LITTLE] = 0;
  Well->occupancyByType[BIG] = 0;

  Well->numWaiting[LITTLE] = 0;
  Well->numWaiting[BIG] = 0;

  Well->numOtherEndWaiting = 0;

  Well->endianTypeInWell = 0;

  return Well;
}

struct Well* Well; // global? weird
// Actually there's a bunch of globals
#define WAITING_HISTOGRAM_SIZE (NUM_ITERATIONS * NUM_PEOPLE)
int             entryTicker;                                          // incremented with each entry
int             waitingHistogram         [WAITING_HISTOGRAM_SIZE];
int             waitingHistogramOverflow;
uthread_mutex_t waitingHistogrammutex;
int             occupancyHistogram       [2] [MAX_OCCUPANCY + 1];






void enterWell (enum Endianness g) {
  // TODO
  // if (Well){
  
  uthread_mutex_lock(Well->mutualExclusionThread);
  
  
  if (Well->occupancy == 0) {
    Well->endianTypeInWell = g;
  }
  if (g == LITTLE){
    //int startingValueTime = entryTicker;
    Well->numWaiting[g]++;
    // could Well->occupancyByType[oppositeEnd[g]] work??
    while (Well->occupancy == MAX_OCCUPANCY || Well->endianTypeInWell != g || Well->occupancyByType[BIG] > 0) {
      // startingValueTime++;
      uthread_cond_wait(Well->endianTypeInWellCond[g]);
    }
    Well->numWaiting[g]--;
    // int endingValueTime = entryTicker
    //recordWaitingTime(endingValueTime - startingValueTime);
    Well->occupancy++;
    Well->occupancyByType[g]++;
    occupancyHistogram[g][Well->occupancy]++;
  } else if (g == BIG) {
    //int startingValueTime = entryTicker;
    Well->numWaiting[g]++;
    // could Well->occupancyByType[oppositeEnd[g]] work??
    while (Well->occupancy == MAX_OCCUPANCY || Well->endianTypeInWell != g || Well->occupancyByType[LITTLE] > 0) {
      // startingValueTime++;
      uthread_cond_wait(Well->endianTypeInWellCond[g]);
    }
    Well->numWaiting[g]--;
    // int endingValueTime = entryTicker
    //recordWaitingTime(endingValueTime - startingValueTime);
    Well->occupancy++;
    Well->occupancyByType[g]++;
    occupancyHistogram[g][Well->occupancy]++;
  }
  uthread_mutex_unlock(Well->mutualExclusionThread);
  // }
}

void leaveWell() {
  // TODO
}

void recordWaitingTime (int waitingTime) {
  uthread_mutex_lock (waitingHistogrammutex);
  if (waitingTime < WAITING_HISTOGRAM_SIZE)
    waitingHistogram [waitingTime] ++;
  else
    waitingHistogramOverflow ++;
  uthread_mutex_unlock (waitingHistogrammutex);
}

//
// TODO
// You will probably need to create some additional produres etc.
//
void* gateKeeper() {
  enum Endianness endianness = random() % 2;
  int startingValueTime;
  for (int i = 0; i < NUM_ITERATIONS; i++) {
    startingValueTime = entryTicker;
    enterWell(endianness);

    recordWaitingTime(entryTicker - startingValueTime);

    // yield n times before leaving well
    for (int j = 0; j < NUM_PEOPLE; j++) {
      uthread_yield();
    }

    leaveWell();

    for (int k =  0; k < NUM_PEOPLE; k++) {
      uthread_yield();
    }
  }
}


int main (int argc, char** argv) {
  uthread_init (1);
  Well = createWell();
  uthread_t pt [NUM_PEOPLE];
  waitingHistogrammutex = uthread_mutex_create ();

  // TODO
  for (int i = 0; i < NUM_PEOPLE; i++) {
    pt[i] = uthread_create(gateKeeper, Well);
  }
  for (int i = 0; i < NUM_PEOPLE; i++) {
    uthread_join(pt[i], 0);
  }


  printf ("Times with 1 little endian %d\n", occupancyHistogram [LITTLE]   [1]);
  printf ("Times with 2 little endian %d\n", occupancyHistogram [LITTLE]   [2]);
  printf ("Times with 3 little endian %d\n", occupancyHistogram [LITTLE]   [3]);
  printf ("Times with 1 big endian    %d\n", occupancyHistogram [BIG] [1]);
  printf ("Times with 2 big endian    %d\n", occupancyHistogram [BIG] [2]);
  printf ("Times with 3 big endian    %d\n", occupancyHistogram [BIG] [3]);
  printf ("Waiting Histogram\n");
  for (int i=0; i<WAITING_HISTOGRAM_SIZE; i++)
    if (waitingHistogram [i])
      printf ("  Number of times people waited for %d %s to enter: %d\n", i, i==1?"person":"people", waitingHistogram [i]);
  if (waitingHistogramOverflow)
    printf ("  Number of times people waited more than %d entries: %d\n", WAITING_HISTOGRAM_SIZE, waitingHistogramOverflow);
}
