//Take an MPI struct and disperse it amongst all threads
#include <mpi.h>
#include <stdio.h>

#define NAME_LEN 5
const int NUM_BLOCKS = 3,
		  MASTER = 0;

typedef struct {
	float x,
		  y,
		  z;
	int id_number;
	char name[NAME_LEN];
} vector_t;

MPI_Datatype construct_MPI_vector_datatype ();

int main()
{
	MPI_Init(NULL, NULL);
	
	int rank,
		proc_name_len,
		num_threads;
	char processor[MPI_MAX_PROCESSOR_NAME];
	
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &num_threads);
	MPI_Get_processor_name(processor, &proc_name_len);
	
	int j = 1;
	float k = 0.00;
	MPI_Datatype mpi_vector = construct_MPI_vector_datatype();
	vector_t vectors[num_threads],
			 vec;
	
	for (int i = 1; i < num_threads; i++) {	//[0] skipped -> "dummy" element
		k += 1.01;
		vectors[i].x = k;
		k += 1.01;
		vectors[i].y = k;
		k += 1.01;
		vectors[i].z = k;
		vectors[i].id_number = j;
		sprintf(vectors[i].name, "vec%d", j);
		j++;
	}
	
	MPI_Scatter(vectors, 1, mpi_vector, &vec, 1, mpi_vector, MASTER, MPI_COMM_WORLD);	//sends to all including master
	
	if (!(rank == MASTER)) {
		printf("Proc: %s, Rank: %d, Name: %s, ID# %d -> x: %.2f, y: %.2f, z: %.2f\n",
			   processor, rank, vec.name, vec.id_number, vec.x, vec.y, vec.z);
	}
	
	//this will also print out the master's garbage vector info
	/*for (int i = 0; i < num_threads; i++) {
		if (rank == i) {
			printf("Proc: %s, Rank: %d, Name: %s, ID# %d -> x: %.2f, y: %.2f, z: %.2f\n",
				   processor, rank, vec.name, vec.id_number, vec.x, vec.y, vec.z);
		}
	}*/
	
	MPI_Type_free(&mpi_vector);
	MPI_Finalize();
	return 0;
}

MPI_Datatype construct_MPI_vector_datatype ()
{
	int block_count[NUM_BLOCKS];
	MPI_Aint extent,
			 lower_bound,
			 offsets[NUM_BLOCKS];
	MPI_Datatype old[NUM_BLOCKS],
				 vector_name,
				 datatype;
	
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
	
	MPI_Type_create_struct(NUM_BLOCKS, block_count, offsets, old, &datatype);
	MPI_Type_commit(&datatype);
	return datatype;
}
