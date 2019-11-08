## Unified Memory Management

pgcc -acc -fast -ta=tesla:cc60,managed -Minfo=accel jacobi.c laplace2d.c -o jacobi