CFLAGS += -std=gnu11 -g
EXES    = greet

all:  $(EXES)
clean:
	rm -f $(EXES)

greet: greet.c
# don't treat all and clean as file targets
.PHONY: all clean
