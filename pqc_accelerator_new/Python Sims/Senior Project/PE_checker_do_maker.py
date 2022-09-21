import numpy as np

N = 8

def createFile(A, B, filepath):
    file = open(filepath, 'w')
    try:
        file.write("restart\n")
        file.write("force clock 0 0, 1 5ns -repeat 10ns\n")
        file.write("force reset 1 0ns, 0 10ns\n")
        file.write("force load 0 0ns, 1 10ns\n")
        file.write("force clear 0 0ns\n")
        for i in range(0, 2):
            if i == 0:
                file.write("\nforce A_in ")
            else:
                file.write("\nforce B_in ")
            for j in range(0, len(A)):
                if i == 0:
                    num = np.binary_repr(int(A[N-1][j]), width=1)
                    if j == 0:
                        file.write(num+" "+str(10*(j+1)+10)+"ns")
                    else:
                        file.write(", "+num+" "+str(10*(j+1)+10)+"ns")
                else:
                    num = np.binary_repr(int(B[j][0]), width=8)
                    if j == 0:
                        file.write(num+" "+str(10*(j+1)+10)+"ns")
                    else:
                        file.write(", "+num+" "+str(10*(j+1)+10)+"ns")

        file.write("\n\nrun 700000ns")
                
    finally:
        file.close()
