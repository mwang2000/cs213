#include <stdlib.h>
#include <stdio.h>

#include "mymalloc.h"

/* Feel free to change/remove these variables and/or add your own. */

// Base address of the allocated heap.
static char *heap;
// Size of the complete heap.
static int heapsize;
// Next unallocated location in the heap.
static int top;

static struct Metadata* head = NULL;

struct Metadata {
  int size;
  struct Metadata* next;
};


/* Initialize your memory manager to manage the given heap. */
void mymalloc_init(char *_heap, int _heapsize) {
  heap = _heap;
  heapsize = _heapsize;
  top = 0;
  /* TODO: Any other initialization you want to do */
  /* NOTE! Each call to mymalloc_init should initialize a brand new heap
     (discarding the old one), as it will be called once per test.
     Therefore, be sure to *initialize all your variables* here! */
}

/* Allocate a block of memory of the given size, or NULL if unable. 

Returns: a pointer aligned to 8 bytes, or NULL if allocation failed. */
void *mymalloc(int size) {
  /* This is a dumb implementation of malloc, adapted slightly from the slides. 

  You will augment this solution to make a real malloc. */

  /* Round `size` up to a multiple of 8 bytes */
  /* TODO: Make room for any extra metadata you want to store */
  size = (size + 7) / 8 * 8 + 16;
  /* TODO: Implement and walk a free list before allocating off `top` as a last resort */
  struct Metadata* temp = head;
  struct Metadata* prev = NULL;
  
  // takes out block from free list and returns a pointer to that address + 16
  // if (head != NULL) {
  //   if (temp->size >= size) {
  //   if (head->next != NULL) {
  //     head = head->next;
  //   } else {
  //     head = NULL;
  //   }
  //   void *freeSpace = &temp + 16; 
  //   return freeSpace;
  //   }
  // }
    // printf("%d\n",head->size);

    // printf("%d\n",temp->size);

  while (temp != NULL) {
    if (temp->size >= size) {
      prev = temp;
      temp = temp->next;
      if (temp->next != NULL) {
      prev->next = temp->next;
      } else {
        prev->next = NULL;
      }
      void *freeSpace = &temp + 16; 
      return freeSpace;
    } else {
      temp = temp->next;
    }
  }


  if(size < 0 || size > heapsize || heapsize - size < top) {
    /* There is not enough room in the heap - fail */
    return NULL;
  }
  /* Allocate the memory from `top` to `top+size` and return it */
  temp = (struct Metadata*) &heap[top];
  temp->size = size;
  temp->next = NULL;
  void *res = &heap[top] + 16;
  top += size;
  return res;
}

/* Free the given block of memory. */
void myfree(void *ptr) {
  struct Metadata* meta = ptr - 16;
  printf("%d\n",meta->size);

  printf("%d\n",meta->next);

  if (head == NULL) {
    head = meta;
  } else if (head != NULL) {
    meta->next = head;
    head = meta;
  } 
}
