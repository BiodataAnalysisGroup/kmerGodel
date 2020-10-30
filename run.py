import os
import sys

if __name__ == "__main__":

    kmin = int(sys.argv[1])
    kmax = int(sys.argv[2])
    k_vals = list(range(kmin,kmax+1))
    inputfile = str(sys.argv[3])
    
    for k in k_vals:
        os.system("python3 k-mer.py " + str(k) + " " + inputfile)
