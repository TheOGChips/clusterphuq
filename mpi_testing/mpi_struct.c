#include <mpi.h>
#include <stdio.h>

#define NUM_VECTORS 3
#define NAME_LEN 5
const int NUM_BLOCKS = 3;

typedef struct {
	float x,
		  y,
		  z;
	int id_number;
	char name[NAME_LEN];
} vector_t;

//void construct_MPI_vector_datatype (MPI_Datatype * datatype);
MPI_Datatype construct_MPI_vector_datatype (MPI_Datatype datatype);

int main()
{
	MPI_Init(NULL, NULL);
	
	int rank,
		proc_name_len;
	char processor[MPI_MAX_PROCESSOR_NAME];
	
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Get_processor_name(processor, &proc_name_len);
	
	MPI_Datatype mpi_vector;
	//construct_MPI_vector_datatype(&mpi_vector);
	mpi_vector = construct_MPI_vector_datatype(mpi_vector);
	
	if (rank == 0) {
		vector_t vectors[NUM_VECTORS] = {{1.1, 2.2, 3.3, 1, "vec1"},
										{4.4, 5.5, 6.6, 2, "vec2"},
										{7.7, 8.8, 9.9, 3, "vec3"}};
		//vectors[0] = {1.1, 2.2, 3.3, 1, "vec1"};
		//vectors[1] = {4.4, 5.5, 6.6, 2, "vec2"};
		//vectors[2] = {7.7, 8.8, 9.9, 3, "vec3"};
		//printf("Name: %s\n", vectors[0].name);
		MPI_Send(vectors, NUM_BLOCKS, mpi_vector, 1, 0, MPI_COMM_WORLD);
	}
	
	if (rank == 1) {
		vector_t vec[NUM_VECTORS];
		MPI_Status status;
		MPI_Recv(vec, NUM_BLOCKS, mpi_vector, 0, 0, MPI_COMM_WORLD, &status);
		
		for (int i = 0; i < NUM_VECTORS; i++) {
			printf("Name: %s, ID# %d -> x: %.1f, y: %.1f, z:%.1f\n",
				   vec[i].name, vec[i].id_number, vec[i].x, vec[i].y, vec[i].z);
		}
	}
	
	MPI_Type_free(&mpi_vector);
	MPI_Finalize();
	return 0;
}

//void construct_MPI_vector_datatype (MPI_Datatype * datatype)
MPI_Datatype construct_MPI_vector_datatype (MPI_Datatype datatype)
{
	int block_count[NUM_BLOCKS];
	MPI_Aint extent,
			 lower_bound,
			 offsets[NUM_BLOCKS];
	MPI_Datatype old[NUM_BLOCKS],
				 vector_name;
	
	//for the x-y-z vector (3 floating-point #s)
	block_count[0] = 3;
	offsets[0] = 0;
	old[0] = MPI_FLOAT;
	
	//for the ID# (1 int)
	MPI_Type_get_extent(MPI_FLOAT, &lower_bound, &extent); //MPI3
	block_count[1] = 1;
	offsets[1] = 3 * extent;
	old[1] = MPI_INT;
	
	//for the vector's name (c-string, len=5)
	MPI_Type_contiguous(NAME_LEN, MPI_CHAR, &vector_name);
	MPI_Type_get_extent(MPI_INT, &lower_bound, &extent); //MPI3
	block_count[2] = 1;
	offsets[2] = offsets[1] + extent;
	old[2] = vector_name;	//not MPI_CHAR
	/*
	MPI_Type_create_struct(NUM_BLOCKS, block_count, offsets, old, datatype);
	MPI_Type_commit(datatype);
	*/
	MPI_Type_create_struct(NUM_BLOCKS, block_count, offsets, old, &datatype);
	MPI_Type_commit(&datatype);
	return datatype;
}
