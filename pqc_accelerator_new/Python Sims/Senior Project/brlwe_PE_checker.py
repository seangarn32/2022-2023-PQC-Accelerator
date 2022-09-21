# -*- coding: utf-8 -*-

import numpy 
import random
from scipy.linalg import circulant
from PE_checker_do_maker import *

#Definition of ring method
#ring decrements value by 256 until value < 256
def ring(value):
    while value >= 256:
        value -= 256
    while value <= 0:
        value+= 256
    return value

N = 8

matA = circulant([random.randint(0, 1) for i in range(N)])

for i in range(N):
    for j in range(N):
        if j > i:
            matA[i][j] = -1*matA[i][j]
print("\nMatrix A  (", len(matA[0]), "x", len(matA[0]), "):\n", matA)

matB = [[random.randint(0,255)] for i in range(N)]
print("\nMatrix B  (", len(matB[:]), "x", len(matB[0]), "):\n", matB)

matD = np.empty([N,N])

for i in range(N):
    for j in range(N):
        matD[i][j] = matA[j][i]*matB[i][0]

print("\nMatrix D  (", len(matD[:]), "x", len(matD[0]), "):\n", matD)

matFinal = np.zeros([N])


for i in range(N):
    matFinal[i] = np.sum(matD[i])

for k in range(N):
    matFinal[k] = ring(matFinal[k])

print("\nFinal Output (1 x", len(matFinal),"):\n", matFinal)

createFile(matA, matB, "PE_checker.do")