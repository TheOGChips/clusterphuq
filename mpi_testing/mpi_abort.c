#include <mpi.h>
#include <stdio.h>
#include <sched.h>		//sched_yield
#include <stdbool.h>	//true

int main()
{
	int rank;
	
	MPI_Init(NULL, NULL);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	
	// master thread will run for a short time, then abort all other threads
	if (rank == 0) {
		printf("Starting...\n");
		for (int i = 0; i < 10000000; i++) sched_yield();
		printf("Aborting...\n");
		MPI_Abort(MPI_COMM_WORLD, 1);
	}
	
	// all other threads will run indefinitely
	else {
		while (true) sched_yield();
	}
	
	return 0;
}
