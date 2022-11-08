from ctypes.wintypes import INT
import numpy as np

N = 256
T = 20

def createFileHardcode(A, B, filepath):
    file = open(filepath, 'w')
    try:
        file.write("restart -f\n")
        file.write("force clk 0 0 ns, 1 "+str(int(T/2))+" ns -repeat "+str(T)+" ns\n")
        file.write("force rst 1 0 ns, 0 "+str(T)+" ns\n")
        file.write("force ena 0 0 ns, 1 "+str(T)+" ns\n")
        for i in range(0, 2):
            if i == 0:
                file.write("\nforce a_in ")
            else:
                file.write("\nforce b_in ")
            for j in range(0, len(A)):
                if i == 0:
                    num = np.binary_repr(int(A[N-1][N-1-j]), width=1)
                    if j == 0:
                        file.write(num+" "+str(T*(j+1)+15)+"ns")
                    else:
                        file.write(", "+num+" "+str(T*(j+1)+15)+"ns")
                else:
                    num = np.binary_repr(int(B[N-1-j]), width=8)
                    if j == 0:
                        file.write("\""+num+"\" "+str(T*(j+1)+15)+" ns")
                    else:
                        file.write(", \""+num+"\" "+str(T*(j+1)+15)+" ns")

        file.write("\n\nrun 20000ns")
                
    finally:
        file.close()
