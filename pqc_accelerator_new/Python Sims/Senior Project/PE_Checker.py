# -*- coding: utf-8 -*-
"""
Created on 9-19-22

@author: Sean Garner
Adapted from Random Coeffecient Simulator by ansch
"""
import numpy 
import random
from scipy.linalg import circulant
from fileCreate import *

#Definition of ring method
#ring decrements value by 256 until value < 256
#def ring(value):
 #   while value >= 256:
 #       value -= 256
 #   return value

N = 8

matA = circulant([1 for i in range(N)])
for i in range(N):
    for j in range(N):
        if j > i:
             matA[i][j] = - matA[i][j]
print("\nMatrix A  (", len(matA[0]), "x", len(matA[0]), "):\n", matA)

#matA = np.array([1,1,1,1,1,1,1,1])
matB = np.array([0,1,0,0,0,0,0,1])

print("\nMatrix B", matB)

matD = numpy.matmul(matA,matB)

print("\nResult:\n", matD)
