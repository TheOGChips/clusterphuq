#include <mpi.h>
#include <iostream>
#include <cstring>
#include <string>

using namespace std;

int main(int argc, char ** argv)
{
	int world_size,
		rank,
		name_length;
	char processor_name[MPI_MAX_PROCESSOR_NAME];
	
	MPI_Init(&argc, &argv);
		
	MPI_Comm_size(MPI_COMM_WORLD, &world_size);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Get_processor_name(processor_name, &name_length);
	
	cout << "Processor: " << processor_name << ", Rank " << rank << " of " << world_size << endl;
	
	if (argc == 2) {
		//Blocking send and receive
		//if (!strcmp(argv[1], "blocking")) {
		if (string(argv[1]) == "blocking") {
			if (rank == 0) {
				int num = 0;
				MPI_Status status;
				
				cout << "rank: " << rank << ", before: " << num << endl;
				MPI_Send(&num, 1, MPI_INT, 1, 1, MPI_COMM_WORLD);
				MPI_Recv(&num, 1, MPI_INT, 1, 2, MPI_COMM_WORLD, &status);
				cout << "rank: " << rank << ", after: " << num << endl;
			}
			
			else if (rank == 1) {
				int before,
					after;
				MPI_Status status;
				
				MPI_Recv(&before, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, &status);
				after = before + 6;
				//cout << "rank: " << rank << ", after: " << after << endl;
				MPI_Send(&after, 1, MPI_INT, 0, 2, MPI_COMM_WORLD);
			}
		}
		
		//Non-blocking send and receive
		//else if (!strcmp(argv[1], "non-blocking")) {
		else if (string(argv[1]) == "non-blocking") {
			if (rank == 0) {
				int num = 0;
				MPI_Status status;
				MPI_Request request;
				
				cout << "rank: " << rank << ", before: " << num << endl;
				MPI_Isend(&num, 1, MPI_INT, 1, 1, MPI_COMM_WORLD, &request);
				//MPI_Wait(&request, &status);
				MPI_Irecv(&num, 1, MPI_INT, 1, 2, MPI_COMM_WORLD, &request);
				MPI_Wait(&request, &status);
				cout << "rank: " << rank << ", after: " << num << endl;
			}
			
			else if (rank == 1) {
				int before,
					after;
				MPI_Status status;
				MPI_Request request;
				
				MPI_Irecv(&before, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, &request);
				MPI_Wait(&request, &status);
				after = before + 4;
				MPI_Isend(&after, 1, MPI_INT, 0, 2, MPI_COMM_WORLD, &request);
				//MPI_Wait(&request, &status);
			}
		}
	}
	
	else {
		if (rank == 0) cout << "Invalid option!" << endl;
	}
	
	MPI_Finalize();
	
	return 0;
}
