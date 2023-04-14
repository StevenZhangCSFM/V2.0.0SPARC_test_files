import sys
# sys.path.insert(0, '../../../python')

import os
import numpy as np
import argparse
from sparc_function import *

def get_parser():
    parser = argparse.ArgumentParser(description='blablabla')
    parser.add_argument('-p', type=int, default=1, help='number of processors')    
    parser.add_argument('-d', type=str, default='./', help='path of directory')
    # parser.add_argument('-f', type=str, default='data.npy', help='data file')
    return parser

def fdn_test(tol,target_scf,indx):
    wtime_list = []
    print("tol = %e" %(tol))
    # run target first 
    for targetscf_indx, targetscf in enumerate(target_scf):        
        os.system("sed -i '/TOL_SCF:/c TOL_SCF: " + str(target_scf[targetscf_indx]) +  "' *inpt")        

        print("running tol_scf %.5f" %(target_scf[targetscf_indx]))
        os.system("srun ../../../lib/sparc -name He2000 > test.log")
        indx = indx + 1
        [outname,staname] = filenames("He2000", indx)
        if check_INF_NAN(outname) == 1:
            print("Error in running target tol_scf")
            exit(0)
        Eerr, Ferr, wtime = find_err(outname,staname,Ebench,Fbench)
        print("Eerr %.2e, Ferr %.2e, wtime %.2f s" %(Eerr,Ferr,wtime))
        wtime_list.append(wtime)
    return wtime_list


if __name__ == "__main__":
    parser = get_parser()
    args = parser.parse_args()
    p = args.p        
    dir = args.d
    # filename = args.f

    sysname = os.getcwd().split('/')[-1]
    print("doing "+sysname)

    os.chdir(dir)    
    print("starts sparc fdn test")

    # # read data
    # data = np.load(filename)
    # tolscf_list = data[:,0]
    # target_mesh = data[:,1]
    tolscf_list = [5e-4, 1e-3, 3e-3, 5e-3, 8e-3]
    target_mesh = [0.3, 0.3, 0.3, 0.3, 0.3]
    
    bench = np.load("bench.npy")
    Ebench = bench[0][0]
    Fbench = bench[1:,:]

    indx = find_indx()
    wtime_list1 = fdn_test(1e-3,tolscf_list,indx)
    print("wtime_list: ", wtime_list1)

    
