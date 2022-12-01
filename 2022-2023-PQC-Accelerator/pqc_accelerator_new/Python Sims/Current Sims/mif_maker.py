import random


WIDTH = 8 #Same as the size of each B word, e.g. 8 bits
MAXVAL = 2**(WIDTH-1) #Largest absolute value possible of signed width-size number
DEPTH = 256 #Same as N
ADDRESS_RADIX = "UNS" #Data format e.g. unsigned int
DATA_RADIX = "UNS" #Data format e.g. unsigned int
FILEPATH = "test.mif" #output filename

#To generate A .mif
#MEM = [random.randint(0, 1) for i in range(DEPTH)]

#To generate B .mif
MEM = [random.randint(-1*(MAXVAL),MAXVAL-1) for i in range(DEPTH)]

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