#include <stdlib.h>
#include <stdio.h>
#include "refcount.h"

// referenced-counted object looks like this
//   bytes 0..3:        reference count
//   bytes 4..7:        filler to retain client alignment
//   bytes 8..nbytes+7: client portion of allocation
// client gets pointer to byte 8 of allocation, so it looks like
// a normal malloc without the reference count

void* rc_malloc (int nbytes) {
  // allocate nbytes plus room for count, retaining alignment
  int* ref_count = malloc (nbytes + 8);
  // initialize ref count to 1;
  *ref_count = 1;
  // return pointer to client portion of allocation
  return ((void*) ref_count) + 8;
}

void  rc_keep_ref(void* p) {
  // get pointer to ref count from client pointer
  int* ref_count = p - 8;
  // increment ref count
  (*ref_count) ++;
}

void  rc_free_ref(void* p) {
  // get pointer to ref count from client pointer
  int* ref_count = p - 8;
  // decrement ref count
  (*ref_count) --;
  // free allocation when ref count is 0
  if (*ref_count == 0)
    free (ref_count);
}
