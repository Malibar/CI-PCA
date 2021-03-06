####################################################################################################
#   Makefile
#
#   edited by: William Halsey
#   whalsey@g.clemson.edu
#
#   Description: 
#
#   Last edited: Jul. 18, 2013
#
#   
all: clean totalprogram
	rm -f *.o
	@echo "Hello"

totalprogram: grayscale.o matrix_ops.o pca_host.o pca.o ppm.o
	nvcc grayscale.o matrix_ops.o pca_host.o pca.o ppm.o -o pca -lcublas
	
interface: grayscale.o matrix_ops.o pca_host.o classify_image.o ppm.o
	nvcc grayscale.o matrix_ops.o pca_host.o classify_image.o ppm.o -o classify_image -lcublas

classify_image.o: classify_image.cu
	nvcc -c classify_image.cu
	
grayscale.o: grayscale.cu
	nvcc -c grayscale.cu

matrix_ops.o: matrix_ops.cu
	nvcc -c matrix_ops.cu

pca_host.o: pca_host.cu
	nvcc -c pca_host.cu -arch=sm_11

pca.o: pca.cu
	nvcc -c pca.cu

ppm.o: ppm.cu
	nvcc -c ppm.cu

clean:
	rm -rf *.o pca
