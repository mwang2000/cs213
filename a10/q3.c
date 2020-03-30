#include <stdlib.h>
#include <stdio.h>
#include "uthread.h"
#include "uthread_mutex_cond.h"

#define NUM_THREADS 3
uthread_t threads[NUM_THREADS];
uthread_mutex_t mx;
uthread_cond_t has_a;
int remain = NUM_THREADS;

void randomStall() {
  int i, r = random() >> 16;
  while (i++<r);
}

void waitForAllOtherThreads() {
  uthread_mutex_lock(mx);
  remain--;
  if (remain == 0) {
    for (int i = 0; i < NUM_THREADS; i++) {
      uthread_cond_signal(has_a);
    }
  } else {
    while (remain != 0) {
      uthread_cond_wait(has_a);
    }
  }
  uthread_mutex_unlock(mx);
}

void* p(void* v) {
  randomStall();
  printf("a\n");
  waitForAllOtherThreads();
  printf("b\n");
  return NULL;
}

int main(int arg, char** arv) {
  mx = uthread_mutex_create();
  has_a = uthread_cond_create(mx);
  uthread_init(4);
  for (int i=0; i<NUM_THREADS; i++)
    threads[i] = uthread_create(p, NULL);
  for (int i=0; i<NUM_THREADS; i++)
    uthread_join (threads[i], NULL);
  printf("------\n");
}