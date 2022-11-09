# -*- coding: utf-8 -*-

import numpy as np
import random
from scipy.linalg import circulant
from do_maker_hardcode import *

N = 16
MAXVAL = 128

#Definition of ring method
#ring truncates 
def ring(value):
    while value > MAXVAL-1:
        value -= 2*MAXVAL
    while value < -1*MAXVAL:
        value += 2*MAXVAL
    return value

#A[0] is the 0,0 element of the circular matrix
A = [0,1,0,1,0,1,1,1,0,1,0,1,0,1,1,1]
#A = [random.randint(0, 1) for i in range(N)]

matA = circulant(A)
print(matA[:,0])
for i in range(N):
    for j in range(N):
        if i < j:
            matA[i][j] = -1*matA[i][j]
print("\nMatrix A  (", len(matA[0]), "x", len(matA[0]), "):\n", matA)



#Change this
matB = [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]
#matB = [random.randint(-1*(MAXVAL-1),MAXVAL-1) for i in range(N)]

print("\nMatrix B  (", len(matB[:]), "x", len(matB), "):\n", matB)

matC = np.zeros([N,N])
Sums = np.zeros([N])
for i in range(N):
    for j in range(N):
        matC[i][j] = (matB[i]* matA[j][i])
        ring(matC[i][j])

Sums = matC[0]
for i in range(N-1):
    Sums = matC[i+1]+Sums
    for z in range(N):
        Sums[z] = ring(Sums[z])

        
print("\nMatrix C (", len(matC[:]), "x", len(matC[0]), "):\n", matC)
Sums = np.flip(Sums)
print("\nMatrix F (Final Accumulation) (1 x ",len(Sums),"):\n", Sums)

createFileHardcode(matA, matB, "PE_checker_hardcode.do")