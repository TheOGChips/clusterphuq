#include <mpi.h>
#include <stdio.h>
#include <string.h>

const int MASTER = 0;

int main()
{
	MPI_Init(NULL, NULL);
	
	int rank,
		proc_name_len,
		msg_len = strlen("Hello there!") + 1;
	char processor[MPI_MAX_PROCESSOR_NAME],
		 msg[msg_len];
	strcpy(msg, "Goodbye...");
	
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Get_processor_name(processor, &proc_name_len);
	
	if (rank == MASTER) {
		strcpy(msg, "Hello there!");
	}
	
	MPI_Bcast(msg, msg_len, MPI_CHAR, MASTER, MPI_COMM_WORLD);
	
	if (rank == MASTER) {
		printf("Proc: %s, rank: %d -> finished broadcasting...\n", processor, rank);
	}
	
	else {
		printf("Proc: %s, rank: %d -> %s\n", processor, rank, msg);
	}
	
	MPI_Finalize();
	
	return 0;
}
