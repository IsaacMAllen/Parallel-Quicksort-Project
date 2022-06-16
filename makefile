NODEBUGFLAGS = -std=c++14 -fopenmp -O2 -Wall -Werror
DEBUGFLAGS = -g -std=c++14 -fopenmp -Wall -Werror
CFLAGS = $(NODEBUGFLAGS)
OBJS = sorter.o Sorts.o GPUQuickSort.o 
CC = g++
.C.o: 
	scl enable devtoolset-7 'bash --rcfile <(echo "  \
	$(CC) -c $(CFLAGS) -o $@ $<; \
	exit")'
     

all: 
	make sorter 

sorter: $(OBJS)
	scl enable devtoolset-7 'bash --rcfile <(echo "  \
	$(CC) $(OBJS) -fopenmp -o sorter; \
	exit")'


sorter.o: Sorts.h GPUQuickSort.h 

Sorts.o: Sorts.h Sorts.C

GPUQuickSort.o: Sorts.h GPUQuickSort.h GPUQuickSort.C helpers.h

clean:
	rm sorter *.o

