import numpy
from fileCreate import *

N = 256
binary_A = "00100111"
binary_A_neg = "11011001"
binary_B = "1"
binary_C = "10101011"

def ring(value):
    while value >= 256:
        value -= 256
    return value
        
A = numpy.empty((N, N))
for i in range(0, N):
    for j in range(0, N):
        if j > i:
            A[i][j] = int(binary_A_neg, 2)
        else:
            A[i][j] = int(binary_A, 2)

B = numpy.empty((N, 1))
C = numpy.empty((N, 1))
for x in range(0, N):
    B[x][0] = int(binary_B, 2)
    C[x][0] = int(binary_C, 2)

# tmp = numpy.matmul(A, B)

tmp = numpy.empty((N,1))
for i in range(0, N):
    reg = 0
    for j in range(0, N):
        reg = reg + A[i][j] * B[j][0]
    tmp[i][0] = reg

D = numpy.add(tmp, C)
for k in range(0, N):
    D[k][0] = ring(D[k][0])

print(D)

createFile(A, B, C, "../Parts/top_level/SIM/test_top_lv.do")

