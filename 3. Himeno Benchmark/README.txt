Following files are present in this directory:
himenoBMT.c: Implementation of Himeno benchmark.

To compile the code wit PGI compiler:
	
	=> with Unified memory management:
		gpu]$ pgcc -acc -fast -ta=tesla:cc60,managed -Minfo=accel himenoBMT.c -DLARGE -o bmt

	=> Without Unified memory management:
		gpu]$ pgcc -acc -fast -ta=tesla:cc60 -Minfo=accel himenoBMT.c -DLARGE -o bmt

	=> You need to run the himeno benchmark for sizes:
		-> SMALL
		-> MEDIUM
		-> LARGE