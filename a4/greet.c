#include <stdio.h>
#include <stdlib.h>

void greet(char *name, int id) {
  printf("Hello %s!\n", name);
  printf("  You are visitor #%d.\n", id);
}

int main() {
  greet("Kelly", 2000);
  greet("Morgan", 2001);
  return 0;
}
