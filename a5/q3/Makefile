CFLAGS += -std=gnu11 -I..
EXES   =  main
OBJS   =  main.o list.o tree.o element.o ../refcount.o

all: $(EXES)

main: main.o list.o tree.o element.o ../refcount.o

clean:
	rm -f $(EXES) $(OBJS)
tidy:
	rm -f $(OBJS)
