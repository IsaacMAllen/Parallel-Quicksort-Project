NODEBUGFLAGS = -std=c++14 -fopenmp -O2 -Wall -Werror
DEBUGFLAGS = -g -std=c++14 -fopenmp -Wall -Werror
CFLAGS = $(NODEBUGFLAGS)
DEPS = ./sourceFiles/
OBJS = sorter.o Sorts.o ParaQuickSort.o SeqQuickSort.o GpuQuickSort.o
CC = g++
NVCC = /usr/bin/nvcc

#No optmization flags
#--compiler-options sends option to host compiler; -Wall is all warnings
#NVCCFLAGS = -c --compiler-options -Wall

#Optimization flags: -O2 gets sent to host compiler; -Xptxas -O2 is for
#optimizing PTX
NVCCFLAGS = -c -O2 -Xptxas -O2 --compiler-options -Wall


#Flags for debugging
#NVCCFLAGS = -c -G --compiler-options -Wall --compiler-options -g	

.SUFFIXES: .cu .o .h 
	.cu.o:
	    $(NVCC) $(NVCCFLAGS) $(GENCODE_FLAGS) $< -o $@

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

sorter.o: $(DEPS)Sorts.h $(DEPS)SeqQuickSort.h $(DEPS)ParaQuickSort.h $(DEPS)GpuQuickSort.h

Sorts.o: $(DEPS)Sorts.h $(DEPS)Sorts.C

ParaQuickSort.o: $(DEPS)Sorts.h $(DEPS)ParaQuickSort.h $(DEPS)ParaQuickSort.C $(DEPS)helpers.h

SeqQuickSort.o: $(DEPS)Sorts.h $(DEPS)SeqQuickSort.h $(DEPS)SeqQuickSort.C $(DEPS)helpers.h

GpuQuickSort.o: $(DEPS)Sorts.h $(DEPS)GpuQuickSort.h $(DEPS)GpuQuickSort.cu $(DEPS)helpers.h

clean:
	rm sorter *.o

