Rotation in OpenCL
------------------

Sometimes you need to rotate vertices or vectors, for example adjusting 
instrument samples for magnetic declination based on their location. OpenCL is
well equipped for rotation.

Summary 
-------

`rotate2` accepts a float scalar theta which describes the rotation clockwise in
radians. It accepts two float arrays x and y which represent the cartesian
points to be rotated around an origin at (0, 0). It also takes two output
buffers to hold the computed output.

In example.py the kernel code is read from the rotation.cl file. 

1. Determine a platform and device to use.
2. Create an OpenCL context using the selected device.
3. Create buffers to hold the input and outputs.
4. Read the code and compile the kernel program.
5. Create a command queue to execute the commands.
6. Execute the kernel using a scalar input and the buffers.
7. Copy the memory from the device to the host.
8. Print the results
