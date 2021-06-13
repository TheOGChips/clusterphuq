#include <mpi.h>
#include <stdio.h>
#include <sched.h>	//sched_yield

int main()
{
	MPI_Init(NULL, NULL);
	int rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	
	if (rank == 0) {
		float before = MPI_Wtime();
		for (long long int i = 0; i < 10000000; i++) sched_yield();
		float after = MPI_Wtime(),
			  resolution = MPI_Wtick();
		double runtime = after - before;
		printf("Time: %.9f s\nResolution: %.9f\n", runtime, resolution);
	}
	MPI_Finalize();
	
	return 0;
}
