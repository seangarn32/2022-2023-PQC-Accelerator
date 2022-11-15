WIDTH = 8
DEPTH = 256
ADDRESS_RADIX = "UNS"
DATA_RADIX = "UNS"
FILEPATH = "test.mif"

file = open(FILEPATH, 'w')
try:
    file.write("WIDTH = "+str(WIDTH)+";\n")
    file.write("DEPTH = "+str(DEPTH)+";\n\n")
    file.write("ADDRESS_RADIX = "+ADDRESS_RADIX+";\n")
    file.write("DEPTH = "+DATA_RADIX+";\n\n")
    file.write("CONTENT BEGIN\n")
    file.write("\t[0..255]  :   0;\n")
    file.write("END;\n")

finally:
    file.close()