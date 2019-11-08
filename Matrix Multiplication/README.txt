Following files are present in this directory:
matrix-acc-tile.c: Implementation of Matrix multiplication.

To compile the code with PGI compiler:
	
	=> with Unified memory management:
		gpu]$ pgcc -acc -fast -ta=tesla:cc60,managed -Minfo=accel matrix-acc-tile.c -o mat

	=> Without Unified memory management:
		gpu]$ pgcc -acc -fast -ta=tesla:cc60 -Minfo=accel matrix-acc-tile.c -o mat