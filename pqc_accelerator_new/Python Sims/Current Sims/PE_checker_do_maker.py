from ctypes.wintypes import INT
import numpy as np

N = 8
T = 20

def createFile(A, B, filepath):
    file = open(filepath, 'w')
    try:
        file.write("restart -f\n")
        file.write("force clk 0 0, 1 "+str(int(T/2))+"ns -repeat "+str(T)+"ns\n")
        file.write("force rst 1 0ns, 0 "+str(T)+"ns\n")
        file.write("force ena 0 0ns, 1 "+str(T)+"ns\n")
        for i in range(0, 2):
            if i == 0:
                file.write("\nforce A_in ")
            else:
                file.write("\nforce B_in ")
            for j in range(0, len(A)):
                if i == 0:
                    num = ""
                    for k in A[0]:
                        num += str(k)
                    if j == 0:
                        file.write(num+" "+str(T*(j+1))+" ns")
                else:
                    num = np.binary_repr(int(B[j][0]), width=8)
                    if j == 0:
                        file.write("\""+num+"\" "+str(T*(j+1))+" ns")
                    else:
                        file.write(", \""+num+"\" "+str(T*(j+1))+" ns")

        file.write("\n\nrun 700000ns")
                
    finally:
        file.close()
