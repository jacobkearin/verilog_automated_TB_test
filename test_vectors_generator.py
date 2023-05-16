txtoutput = ""
for i in range(512):
    inputxy = bin(i)
    inputxy = inputxy[2:]
    if len(inputxy) == 8:
        inputxy = "0" + inputxy
    elif len(inputxy) == 7:
        inputxy = "00" + inputxy
    elif len(inputxy) == 6:
        inputxy = "000" + inputxy
    elif len(inputxy) == 5:
        inputxy = "0000" + inputxy
    elif len(inputxy) == 4:
        inputxy = "00000" + inputxy
    elif len(inputxy) == 3:
        inputxy = "000000" + inputxy
    elif len(inputxy) == 2:
        inputxy = "0000000" + inputxy
    elif len(inputxy) == 1:
        inputxy = "00000000" + inputxy

    cin = int(inputxy[8])
    inputxy = inputxy[0:8]

    inpx = int(inputxy[0:4], 2)
    inpy = int(inputxy[4:], 2)

    sumout = cin + inpx + inpy

    sumout = str(bin(sumout))[2:]
    if len(sumout) == 4:
        sumout = "0" + sumout
    if len(sumout) == 3:
        sumout = "00" + sumout
    if len(sumout) == 2:
        sumout = "000" + sumout
    if len(sumout) == 1:
        sumout = "0000" + sumout
    
    finout = inputxy + str(cin) + sumout

    txtoutput = txtoutput + finout + "\n"

print(txtoutput, file=open(r"PATH\testvectors.txt", "x"))   #update PATH
#  r"..." for printing raw text output to file 
#  file location is set to directly change textvectors.txt source file from the verilog simulation folder
