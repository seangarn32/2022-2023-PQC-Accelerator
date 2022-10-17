# -*- coding: utf-8 -*-

import numpy as np
import random
from scipy.linalg import circulant
from do_maker_hardcode import *

N = 8 
MAXVAL = 128

#Definition of ring method
#ring truncates 
def ring(value):
    while value >= MAXVAL:
        value -= MAXVAL
    while value <= -1*MAXVAL:
        value += MAXVAL
    return value

#A[0] is the bottom of the first column of A

#Change this
A = [0,0,0,1,1,0,1,0]

#Prepare A for circulant function
A = np.flip(A)
A = np.roll(A,1)

matA = circulant(A)

print("\nInitial column of matrix A: ",matA[0])

for i in range(N):
    for j in range(N):
        if i > j:
            matA[i][j] = -1*matA[i][j]
print("\nMatrix A  (", len(matA[0]), "x", len(matA[0]), "):\n", matA)


#Change this
matB = [0,1,0,0,0,0,0,1]

print("\nMatrix B  (", len(matB[:]), "x", len(matB), "):\n", matB)

matC = np.empty([N,N])

for i in range(N):
    for j in range(N):
        matC[i][j] = matA[i][j]*matB[i]
matC = np.transpose(matC)
print("\nMatrix C (", len(matC[:]), "x", len(matC[0]), "):\n", matC)

matF = np.zeros([N])
for i in range(N):
    matF[i] = sum(matC[i])
for k in range(N):
    matF[k] = ring(matF[k])

print("\nMatrix F (Final Accumulation, Dn+En-1) (",len(matF),"x 1 ):\n", matF)

createFileHardcode(matA, matB, "PE_checker_hardcode.do")