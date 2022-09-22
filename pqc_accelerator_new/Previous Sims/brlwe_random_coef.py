# -*- coding: utf-8 -*-
"""
Created on Tue Nov 30 16:01:29 2021

@author: ansch
"""
import numpy 
import random
from scipy.linalg import circulant
from fileCreate import *

#Definition of ring method
#ring decrements value by 256 until value < 256
def ring(value):
    while value >= 256:
        value -= 256
    return value

N = 256

matA = circulant([random.randint(0, 255) for i in range(N)])

for i in range(N):
    for j in range(N):
        if j > i:
            matA[i][j] = 256 - matA[i][j]
print("\nMatrix A  (", len(matA[0]), "x", len(matA[0]), "):\n", matA)

matB = [[random.randint(0,1)] for i in range(N)]
matC = [[random.randint(0,255)] for i in range(N)]
print("\nMatrix B  (", len(matB[:]), "x", len(matB[0]), "):\n", matB)
print("\nMatrix C  (", len(matC[:]), "x", len(matC[0]), "):\n", matC)

matD = numpy.matmul(matA,matB)
for k in range(N):
    matD[k][0] = ring(matD[k][0])

# print("\n1x256 matrix tmp:\n", matD)

matD = numpy.add(matD,matC)

#Restrains the integers in the resulting D matrix to the range (0-255)
for k in range(N):
    matD[k] = ring(matD[k])
    
print("\nMatrix D  (", len(matD[:]), "x", len(matD[0]), "):\n", matD)

createFile(matA, matB, matC, "test_top_lv.do")

