/*
 	Program to perform reduction using simple work division among arrays and using critical
*/

#include <stdio.h>
#include <omp.h>
#include<stdlib.h>

/* 
	Function to perform reduction by dividing the work manually
*/
void reduction(int *A,int N)
{
	long partial_sum, id, istart, iend, i, final_sum=0; //private variables for loop

//	double par_start = omp_get_wtime();
	# pragma omp parallel private(partial_sum,id,istart,iend,i) \
	  shared(final_sum)
	{
		int num_threads = omp_get_num_threads();

		id = omp_get_thread_num();
		istart = (id * N) / num_threads;		
		iend = ((id+1) * N) / num_threads;
		 
		partial_sum = 0;
	
		// loop to perform reduction in piecewise manner to give partial sum of the chunk
		for(i = istart; i < iend; i++)
		{
			partial_sum += A[i];
		}
		
		// adding the partial sum in to the global sum variable.
		// critical is used for mutual exclusion
		#pragma omp critical
		{
			final_sum += partial_sum;
		}
	}

//	double par_end = omp_get_wtime();

//	printf("MFLOPS = %f\n", N / (1000000*(par_end-par_start)));
//	printf("final sum: %ld \n", final_sum);
} 

int main(int argc, char* argv[])
{
	int N = atoi(argv[1]);
	int i;

	// allocating space for array	
	int *A = (int *) malloc(sizeof(int)*N);

	for(i=0;i<N;i++)
		A[i]=1; //fill the array

	// performing reduction
	double start=omp_get_wtime();
	reduction(A,N);
	double end=omp_get_wtime();

	printf("Time: %f\n",end-start);
	return 0;
}
