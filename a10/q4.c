#include <stdlib.h>
#include <stdio.h>
#include "uthread.h"
#include "uthread_mutex_cond.h"

uthread_t t0, t1, t2;
uthread_mutex_t mx;
uthread_cond_t oneCanGo, twoCanGo;
int thread=0;

void randomStall() {
  int i, r = random() >> 16;
  while (i++<r);
}

void* p0(void* v) {
  uthread_mutex_lock(mx);
  randomStall();
  printf("zero\n");
  thread++;
  uthread_mutex_unlock(mx);
  return NULL;
}

void* p1(void* v) {
  uthread_mutex_lock(mx);
  randomStall();
  if (thread == 1) {
    uthread_cond_signal(oneCanGo);
  } else {
    while(thread != 1) {
      uthread_cond_wait(oneCanGo);
    }
  }
  printf("one\n");
  thread++;
  uthread_mutex_unlock(mx);
  return NULL;
}

void* p2(void* v) {
  uthread_mutex_lock(mx);
  randomStall();
  if (thread == 2) {
    uthread_cond_signal(twoCanGo);
  } else {
    while(thread != 2) {
      uthread_cond_wait(twoCanGo);
    }
  }
  printf("two\n");
  uthread_mutex_unlock(mx);
  return NULL;
}

int main(int arg, char** arv) {
  uthread_init(4);
  mx = uthread_mutex_create();
  oneCanGo = uthread_cond_create (mx);
  twoCanGo = uthread_cond_create (mx);
  t0 = uthread_create(p0, NULL);
  t1 = uthread_create(p1, NULL);
  t2 = uthread_create(p2, NULL);
  randomStall();
  uthread_join (t0, NULL);
  uthread_join (t1, NULL);
  uthread_join (t2, NULL);
  printf("three\n");
  printf("------\n");
}