# -*- coding: utf-8 -*-

import numpy as np
import random
from scipy.linalg import circulant
from PE_checker_do_maker import *

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

matA = circulant([1,1,1,1,1,1,1,1])

print("\nInitial column of matrix A: ",matA[0])

for i in range(N):
    for j in range(N):
        if i > j:
            matA[i][j] = -1*matA[i][j]
print("\nMatrix A  (", len(matA[0]), "x", len(matA[0]), "):\n", matA)

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

createFile(matA, matB, "PE_checker.do")