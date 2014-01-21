__kernel void rotate2(float theta,
                     __global const float *x,
                     __global const float *y,
                     __global float *fx,
                     __global float *fy) {
    float s = sin(theta);
    float c = cos(theta);
    int i = get_global_id(0);
    fx[i] =  c * x[i] + s * y[i];
    fy[i] = -s * x[i] + c * y[i];

}

