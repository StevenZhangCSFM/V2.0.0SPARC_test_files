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

def series_test(tol, target_scf, target_mesh, name, indx):
    wtime_list = []
    print("tol = %e" %(tol))
    # run target first 
    for theMesh in target_mesh:
        os.system("sed -i '/MESH_SPACING:/c MESH_SPACING: " + str(theMesh) +  "' *inpt")
        for theTolscf in target_scf:        
            os.system("sed -i '/TOL_SCF:/c TOL_SCF: " + str(theTolscf) +  "' *inpt")        
            print("running mesh %.5f, tol_scf %.5f" %(theMesh, theTolscf))
            os.system("srun ../../../lib/sparc -name " + name + " > test.log")
            indx = indx + 1
            [outname,staname] = filenames(name, indx)
            if check_INF_NAN(outname) == 1:
                print("Error in running target tol_scf")
                exit(0)
            Eerr, Ferr, wtime = find_err(outname,staname,Ebench,Fbench)
            print("Eerr %.2e, Ferr %.2e, wtime %.2f s" %(Eerr,Ferr,wtime))
            wtime_list.append(wtime)
    return wtime_list

def bench_test(tol_scf, mesh_spacing, atomAmount, runFlag, name):       
    if runFlag:
        os.system("sed -i -e '$aTOL_SCF: " + str(tol_scf) +  "' *inpt")
        os.system("sed -i '/MESH_SPACING:/c MESH_SPACING: " + str(mesh_spacing) +  "' *inpt")  
        print("running tol_scf %.5f, mesh %.6f" %(tol_scf, mesh_spacing))
        os.system("srun ../../../lib/sparc -name " + name + " > test.log")
        # change the name of output files
        os.system("mv " + name + ".out " + name + ".benchout")
        os.system("mv " + name + ".static " + name + ".benchstatic")
    # extract data
    outDir = "./" + name + ".benchout"
    Ebench = getEnergy(outDir)
    staticDir = "./" + name + ".benchstatic"
    Fbench = getForce(staticDir, atomAmount)
    return Ebench, Fbench


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
    print("starts sparc fdn test")
    Ebench, Fbench = bench_test(1e-5, 0.15, atomNumber, 0, name) # TOL_SCF, MESH_SPACING

    tolscf_list = [1e-4, 3e-4, 9e-4]
    mesh_list = [0.16]

    indx = find_indx()
    print("indx %d" %indx)
    wtime_list1 = series_test(1e-3, tolscf_list, mesh_list, name, indx)
    print("wtime_list: ", wtime_list1)
