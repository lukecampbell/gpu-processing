
/*
 * blerp
 * Evaluates the bilinear interpolation of a set over a grid
 */

__kernel void blerp(const uint M, /* Size of first dimension */
                    const uint N, /* Size of second dimension */
                    __global const float *X, /* values for first dimension (size is M) */
                    __global const float *Y, /* values for second dimension (size is N) */
                    __global const float *Z, /* Array of values (size is M*N */
                    __global const float *x, /* Input along first dimension */
                    __global const float *y, /* Input along second dimension */
                    __global float *z) /* output */
{
    int m = get_global_id(0); // Get the index for the first dim
    int n = get_global_id(1); // Get the index for the second dim
    uint i=0; // The highest index i that satisfies X[i] < x[i]
    uint j=0; // The highest index j that satisfies Y[j] < y[j]
    // Find the nearest floor of x and y
    z[n*M + m] = m+2;
    /*
    if(i == M || j == N) {
        z[M*j + i] = NAN;
    }*/
}


