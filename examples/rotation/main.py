import pyopencl as cl
import numpy as np
import sys

rotation_cl = 'rotation.cl'

def main(device_id):
    # Rottation of 90 degrees clockwise
    theta = np.pi / 2
    x = np.array([0,1], dtype=np.float32)
    y = np.array([1,0], dtype=np.float32)
    
    # Get the first available platform
    platform = cl.get_platforms()[0]
    print 'Operating on', platform.name
    # Get the device using the device_id passed in
    device = platform.get_devices()[device_id]
    print 'Device:', device.name

    # Create the OpenCL Context
    ctx = cl.Context([device])
    mf = cl.mem_flags

    # Create the input and output buffers
    x_buf = cl.Buffer(ctx, mf.READ_ONLY | mf.COPY_HOST_PTR, hostbuf=x)
    y_buf = cl.Buffer(ctx, mf.READ_ONLY | mf.COPY_HOST_PTR, hostbuf=y)

    fx_buf = cl.Buffer(ctx, mf.WRITE_ONLY, size=x.nbytes)
    fy_buf = cl.Buffer(ctx, mf.WRITE_ONLY, size=y.nbytes)

    # Load, compile and link the OpenCL program
    with open(rotation_cl, 'r') as f:
        kernel_code = f.read()
    prg = cl.Program(ctx, kernel_code).build()

    queue = cl.CommandQueue(ctx)

    # Execute the program through queue. Global size is x.shape, local size is 
    # automatically determined by specifying None, theta is a scalar but needs to 
    # be cast to np.float32.
    event = prg.rotate2(queue, x.shape, None, np.float32(theta), x_buf, y_buf, fx_buf, fy_buf)
    event.wait()

    fx = np.empty(x.shape, dtype=np.float32)
    fy = np.empty(y.shape, dtype=np.float32)

    # Copy the device memory to the host
    cl.enqueue_copy(queue, fx, fx_buf)
    cl.enqueue_copy(queue, fy, fy_buf)

    print fx
    print fy

if __name__ == '__main__':
    device_id = int(sys.argv[1])
    main(device_id)
