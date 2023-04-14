#include <stdio.h>
#include <mpi.h>
#include <math.h>


int main(int argc, char **argv) {
    MPI_Init(&argc,&argv);
    int rank, size;
    
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    
    if (!rank)
        printf("Hello world from %d/%d\n",rank,size);
    
    // test allreduce
    int sum = 0;
    MPI_Allreduce(&rank, &sum, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
    
    printf("sum = %d in rank %d\n",sum, rank);
    
#ifdef NAN
    printf("nan defined!\n");
#endif


    double a;
    a = NAN;
    printf("NAN = %f\n",NAN);
    if (a != a) 
        printf("a is nan!\n");
    else 
        printf("a is not nan\n");
    printf("a = %f\n", a);

    printf("isnan(a) = %d\n", isnan(a));
    MPI_Finalize();
    return 0;
}
