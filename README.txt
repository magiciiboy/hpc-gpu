Compiling instructions for individual codes are in the README's inside respective directories.

------------------------------------------------------
Instructions to use GPU nodes on bridges:
-	To get access to a GPU node on bridges:
		login]$ interact -N 1 -gpu --gres=gpu:p100:1 -t hh:mm:ss

	Your console should change from "login" to "gpu".

-	Required modules:
	pgi/19.7
	cuda/10.0

	Make sure you have the above modules loaded for same version as shown to avoid issues with profiling.

-	To compile a code for GPU with Unified Memory Management:
		gpu]$ pgcc -acc -fast -ta=tesla:cc60,managed -Minfo=accel <source code> -o <executable>

-	To compile a code for GPU with Explicit data management, remove “managed” parameter from command above.

-	Remember that if you have define explicit data management in your code, but compile it with "managed" clause,
	the compiler and openACC runtime will ignore all user defined data management strategy and use unified memory management instead.

-	Get GPU info:
		gpu]$ pgaccelinfo

-	Get available metrics information for the GPU:
		gpu]$ nvprof --query-metrics
------------------------------------------------------

------------------------------------------------------
-	A few OpenACC clauses that will be helpful:
	1.	“#pragma omp parallel for”

	2. “#pragma acc kernels”

	3.	“reduction(<operator> : <operand>)” clause: similar to openMP.

	4.	“copy( list )” : Allocates memory on GPU and copies data from host to GPU when
		entering region and copies data back to the host when exiting region.

	5.	“copyin( list )” : Allocates memory on GPU and copies data from host to GPU when
		entering region.
	
	6.	“copyout( list )” : Allocates memory on GPU and copies data to the host when exiting
		region.
	
	7.	“create( list )” : Allocates memory on GPU but does not copy.

	8. 	num_gangs( <expression> ), num_workers( <expression> ), vector_length( <expression> )
		- Reference: https://www.nvidia.com/docs/IO/116711/OpenACC-API.pdf
------------------------------------------------------

------------------------------------------------------
Profiling GPU codes:

	-	To get number of DRAM transactions:

		gpu]$ nvprof --cpu-profiling on --metrics dram_read_transactions ./<executable>

		- Remember, this metric reports number of transactions PER KERNEL INVOCATION. 

		- For each section you want to measure amount of data transferred between DRAM and GPU cores, 
		  you have to multiply the metric value with "Number of kernel invocations" (reported alongside the metric),
		  and with size of the datatype.

	-	To get Double-precision operations RATE (DPFLOPs):

		gpu]$ nvprof --cpu-profiling on --metrics flop_count_dp ./<executable>

		- Again, you need to multiply the metric count to "Number of kernel invocations".

	-	To get Timings and Power consumption:

		gpu]$ nvprof --system-profiling on ./<executable>

		This output also provides a breakdown of %time taken by different sections of the source code as well as internal CUDA kernels.

	-	To save output to a human readable format:

		gpu]$ nvprof --csv --system-profiling on --devices 0 --log-file human-readable-output_A.log ./<executable>
------------------------------------------------------