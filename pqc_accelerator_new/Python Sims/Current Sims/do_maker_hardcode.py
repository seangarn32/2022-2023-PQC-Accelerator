from ctypes.wintypes import INT
import numpy as np

N = 8
T = 20
Z_off = 315

def createFileHardcode(A, B, Z, filepath):
    file = open(filepath, 'w')
    try:
        file.write("restart -f\n")
        file.write("force clk 0 0 ns, 1 "+str(int(T/2))+" ns -repeat "+str(T)+" ns\n")
        file.write("force rst 1 0 ns, 0 "+str(T)+" ns\n")
        file.write("force ena 0 0 ns, 1 "+str(T)+" ns\n")
        file.write("force z_in 0\n")
        for i in range(0, 3):
            if i == 0:
                file.write("\nforce a_in ")
            if i == 1:
                file.write("\nforce b_in ")
            if i == 2:
                file.write("\nforce z_in ")
            for j in range(0, len(A)):
                if i == 0:
                    num = np.binary_repr(int(A[j][0]), width=1)
                    if j == 0:
                        file.write(num+" "+str(T*(j+1)+15)+" ns")
                    else:
                        file.write(", "+num+" "+str(T*(j+1)+15)+" ns")
                if i == 1:
                    num = np.binary_repr(int(B[j]), width=8)
                    if j == 0:
                        file.write("\""+num+"\" "+str(T*(j+1)+15)+" ns")
                    else:
                        file.write(", \""+num+"\" "+str(T*(j+1)+15)+" ns")
                if i == 2:
                    num = np.binary_repr(int(Z[j]), width=1)
                    if j == 0:
                        file.write(num+" "+str(T*(j+1)+Z_off)+" ns")
                    else:
                        file.write(", "+num+" "+str(T*(j+1)+Z_off)+" ns")
        runtime = str((T*N)+(Z_off*2))
        file.write("\n\nrun "+runtime+"ns")
                
    finally:
        file.close()
