import random

WIDTH = 8 #Same as the size of each B word, e.g. 8 bits
MAXVAL = 2**(WIDTH-1) #Largest absolute value possible of signed width-size number
ADDRESS_RADIX = "UNS" #Data format e.g. unsigned int
DATA_RADIX = "UNS" #Data format e.g. unsigned int

def createMif(MEM, N, FILEPATH):
    DEPTH = N
    file = open(FILEPATH, 'w')
    try:
        file.write("WIDTH = "+str(WIDTH)+";\n")
        file.write("DEPTH = "+str(DEPTH)+";\n\n")
        file.write("ADDRESS_RADIX = "+ADDRESS_RADIX+";\n")
        file.write("DEPTH = "+DATA_RADIX+";\n\n")
        file.write("CONTENT BEGIN\n")
        j = 0
        for i in MEM:
            file.write("\t["+str(j)+"]  :   "+str(i)+";\n")
            j+=1
        file.write("END;\n")
    finally:
        file.close()