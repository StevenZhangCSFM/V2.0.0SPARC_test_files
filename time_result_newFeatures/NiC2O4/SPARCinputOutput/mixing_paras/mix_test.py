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
    parser.add_argument('-name', type=str, default='spar_calc', help='name of the system')
    parser.add_argument('-atomn', type=int, default=2, help='total amount of atoms in the system')
    # parser.add_argument('-f', type=str, default='data.npy', help='data file')
    return parser

def series_test(tol, target_mixing, target_mesh, name, indx):
    wtime_list = []
    print("tol = %e" %(tol))
    # run target first 
    for theMesh in target_mesh:
        os.system("sed -i '/MESH_SPACING:/c MESH_SPACING: " + str(theMesh) +  "' *inpt")
        for theMixing in target_mixing:        
            os.system("sed -i '/MIXING_PARAMETER:/c MIXING_PARAMETER: " + str(theMixing) +  "' *inpt")        
            print("running mesh %.5f, mixing_paras %.5f" %(theMesh, theMixing))
            os.system("srun ../../../lib/sparc -name " + name + " > test.log")
            indx = indx + 1
            [outname,staname] = filenames(name, indx)
            if check_INF_NAN(outname) == 1:
                print("Error in running target tol_scf")
                exit(0)
            wtime = getWalltime(outname)
            print("wtime %.2f s" %(wtime))
            wtime_list.append(wtime)
    return wtime_list


if __name__ == "__main__":
    parser = get_parser()
    args = parser.parse_args()
    p = args.p        
    dir = args.d
    name = args.name
    atomNumber = args.atomn

    sysname = os.getcwd().split('/')[-1]
    print("doing "+sysname)

    os.chdir(dir)    

    mixing_list = [0.3, 0.5, 0.7, 0.9]
    mesh_list = [0.24]

    indx = find_indx()
    print("indx %d" %indx)
    wtime_list1 = series_test(1e-3, mixing_list, mesh_list, name, indx)
    print("wtime_list: ", wtime_list1)
