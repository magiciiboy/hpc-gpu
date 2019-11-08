Following files are present in this directory:
*.c and *.h: Implementation of jacobi heat equation solver.

To compile the code wit PGI compiler:
	
	=> with Unified memory management:
		gpu]$ pgcc -acc -fast -ta=tesla:cc60,managed -Minfo=accel jacobi.c laplace2d.c -o jacobi

	=> Without Unified memory management:
		gpu]$ pgcc -acc -fast -ta=tesla:cc60 -Minfo=accel jacobi.c laplace2d.c -o jacobi