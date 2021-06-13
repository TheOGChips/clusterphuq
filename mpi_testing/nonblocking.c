#include <mpi.h>
#include <stdio.h>
#include <string.h>

const int MASTER = 0;
const int TAG = 0;

int main()
{
	int num_threads;
	
	MPI_Init(NULL, NULL);
	
	int rank,
		proc_name_len;
	const int ODD_LEN = 3,
			  EVEN_LEN = 4;
	char * odd = "odd",
		 * even = "even",
		 processor[MPI_MAX_PROCESSOR_NAME];
	
	MPI_Comm_size(MPI_COMM_WORLD, &num_threads);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	
	if (rank == MASTER) {
		for (int i = 1; i < num_threads; i++) {
			char * msg;
			
			if (i % 2 == 0) msg = even;
			else msg = odd;
			
			MPI_Send(msg, strlen(msg) + 1, MPI_CHAR, i, TAG, MPI_COMM_WORLD);	// + 1 needed for null char -> '\0'
		}
	}
	
	else {
		const int MAX_MSG_LEN = 5;
		char msg[MAX_MSG_LEN];	//this won't work as a pointer (char * msg)
		MPI_Status status;
		MPI_Request request;
		
		MPI_Irecv(msg, MAX_MSG_LEN, MPI_CHAR, MASTER, TAG, MPI_COMM_WORLD, &request);
		MPI_Get_processor_name(processor, &proc_name_len);
		
		MPI_Wait(&request, &status);
		printf("Proc: %s, Rank: %d, Msg: %s\n", processor, rank, msg);
	}
	
	MPI_Finalize();
	
	return 0;
}
