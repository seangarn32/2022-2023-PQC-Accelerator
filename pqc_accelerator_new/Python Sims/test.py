import numpy as np
import random
from scipy.linalg import circulant

a = -126
b = -126
# Calculating binary value using function
sum = bin(a+b)
sum = sum[sum.index('b')+1:]
sum = sum[-8:len(sum)]
print(sum)
if(sum[0] == '0'):
    sum = sum[-7:len(sum)]
    x = int(sum,2)
    print(x)
else:
    sum = sum[-7:len(sum)]
    x = int(sum,2)
    print(x)
# Printing result
print(x)


