#include <mpi.h>
#include <stdio.h>

int main()
{
	int rank;
	
	MPI_Init(NULL, NULL);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	
	if (rank == 0) {
		int version,
			subversion;
		MPI_Get_version(&version, &subversion);
		printf("MPI Version: %d.%d\n", version, subversion);
	}
	
	MPI_Finalize();
	
	return 0;
}
