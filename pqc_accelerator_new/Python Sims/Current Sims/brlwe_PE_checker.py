# -*- coding: utf-8 -*-

import numpy 
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

matA = circulant([random.randint(0, 1) for i in range(N)])
print(matA)
for i in range(N):
    for j in range(N):
        if i > j:
            matA[i][j] = -1*matA[i][j]
print("\nMatrix A  (", len(matA[0]), "x", len(matA[0]), "):\n", matA)

matB = [[random.randint(0,MAXVAL)] for i in range(N)]
print("\nMatrix B  (", len(matB[:]), "x", len(matB[0]), "):\n", matB)

matD = np.empty([N,N])

for i in range(N):
    for j in range(N):
        matD[i][j] = matA[i][j]*matB[i][0]
matD = np.transpose(matD)
print("\nMatrix D  (", len(matD[:]), "x", len(matD[0]), "):\n", matD)

matE = np.zeros([N])

for i in range(N):
    matE[i] = np.sum(matD[i])
for k in range(N):
    matE[k] = ring(matE[k])
matE[-1] = 0
print("\nMatrix E (Sums of D rows, last value is 0 since the final sum is not used) ( 1 x",len(matE),"):\n", matE)

matF = np.zeros([N])
for i in range(N):
    matF[i] = sum(matD[i])+matE[i-1]
for k in range(N):
    matF[k] = ring(matF[k])

print("\nMatrix F (Final Accumulation, Dn+En-1) (",len(matF),"x 1 ):\n", matF)

createFile(matA, matB, "PE_checker.do")