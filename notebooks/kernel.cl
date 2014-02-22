
#define TIMESTEPS   %(t)s 

#define DT %(dt)s

/*
 * Do bilerp
 */


/*
 * euler
 * Determines the particle movement across a system
 * using a flow-field described by u and v grids
 *
 * global_id is the particle number
 *
 * MxN grid as input
 *
 * M - (scalars) number of elements in the grid along the horizontal axis
 * N - (scalars) number of elements in the grid along the vertical axis
 *
 * U - u-vectors grid as an M by N array
 * V - v-vectors grid as an M by N array
 *
 * U is in meters per second
 * V is in meters per second
 *
 * x - x-positions of the particle of length P
 * y - y-positions of the particle of length P 
 *
 * xp and yp, not sure what they're just yet but they have
 * a real purpose, I promise.
 */
__kernel void euler(const uint M,
                    const uint N,
                    __global const float *U,
                    __global const float *V,
                    __global const float *x,
                    __global const float *y,
                    __global float *xp,
                    __global float *yp)
{
  int i = get_global_id(0); // get the particle number
  // set the initial positions
  xp[i] = x[i]; 
  yp[i] = y[i];
  for(int t=0; t < TIMESTEPS; t++) {
    int u_i = (int) xp[i];
    int v_i = (int) yp[i];
    float u = U[u_i];
    float v = V[v_i];
    xp[i] = xp[i] + u * DT;
    yp[i] = yp[i] + v * DT;
  }
}

