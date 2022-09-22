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

def bool2int(x):
    y = 0
    for i,j in enumerate(x):
        y += j<<i
    return y


matA = circulant([1,0,1,1,0,1,1,1])
for i in range(N):
    for j in range(N):
        if j > i:
             matA[i][j] = - matA[i][j]
print("\nMatrix A  (", len(matA[0]), "x", len(matA[0]), "):\n", matA)

matA = np.flip(matA)
matB = np.array([[0,0,0,1,1,1,1,1],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[1,0,1,0,1,0,0,0],[0,0,0,0,0,0,0,0],[0,0,1,1,1,1,0,0],[0,0,0,0,0,0,0,1],[0,0,1,1,1,1,0,0]])

print("\nMatrix B", matB)

#matA = np.transpose(matA)
#print("\nTransposed Matrix A  (", len(matA[0]), "x", len(matA[0]), "):\n", matA)

i = 0
j = 0
matC = np.empty((8,8))
#sumS = np.empty((1,8))
while i < N:
    while j < N:
        matC[i][j] = matA[j][i]*matB[i] #matC row 0 is a list of B0 x a1,a2,a3...
        j+=1
    i+=1        
        
print(matC)
