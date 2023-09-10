# all functions related to reading values from python output files
import sys
import os
import numpy as np
import re
import random as rd

def check_occ(logname):
    file_read = open(logname, "r")
    lines = file_read.readlines()
    occ = 1
    flag = 0
    for line in lines:
        if "Occupation of state" in line:
            flag = 1
            nocc = float(re.findall("\d+\.\d+", line.split('=')[1])[0])
            if nocc < occ:
                occ = nocc
    if flag == 0:
        occ = None
    return occ

def filenames(sysname, indx):
    if indx == 0:
        filename_out = sysname + ".out"
        filename_sta = sysname + ".static"
    else:
        filename_out = sysname + ".out_" + "{:02d}".format(indx)
        filename_sta = sysname + ".static_" + "{:02d}".format(indx)
    return [filename_out, filename_sta]


def getEnergy(file):
    energy = None
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    for lines in f_out_content:
        if re.findall(r"Free energy per atom",lines) == ['Free energy per atom']:
            energy = float(re.findall(r'[+-]?\d+\.\d+[E][+-]\d+',lines)[0])
    return energy


def getNatom(file):
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    for lines in f_out_content:
        if re.findall(r"Total number of atoms",lines) == ['Total number of atoms']:
            natom = int(re.findall(r'\d+',lines)[0])
    return natom

def getNelec(file):
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    for lines in f_out_content:
        if re.findall(r"Total number of electrons",lines) == ['Total number of electrons']:
            Nelec = int(re.findall(r'\d+',lines)[0])
    return Nelec

def getNp(file):
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    for lines in f_out_content:
        if re.findall(r"Number of processors",lines) == ['Number of processors']:
            Np = int(re.findall(r'\d+',lines)[0])
    return Np

def getFDn(file):
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    for lines in f_out_content:
        if re.findall(r"FD_ORDER",lines) == ['FD_ORDER']:
            fdn = int(re.findall(r'\d+',lines)[0])
    return fdn

def getWalltime(file):
    wtime = 0
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    for lines in f_out_content:
        if re.findall(r"Total walltime ",lines) == ['Total walltime ']:
            wtime = float(re.findall(r'[+-]?\d+\.\d+',lines)[0])
    return wtime

def getForce(file,natom):
    force = []
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    flag = 0
    for lines in f_out_content:
        if flag > 0 and flag < natom+1:
            force.append([float(f) for f in lines.split('  ')])
            flag = flag + 1
        if re.findall(r"Atomic forces",lines) == ['Atomic forces']:            
            flag = 1     
    return np.array(force)

def getStress(file):
    stress = []
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    flag = 0
    for lines in f_out_content:
        if flag > 0 and flag < 4:            
            stress.append([float(f) for f in lines.split('  ')])
            flag = flag + 1
        if re.findall(r"Stress",lines) == ['Stress']:            
            flag = 1     
    return stress

def getStressFlag(file):
    stress_flag = 0
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]    
    for lines in f_out_content:
        if re.findall(r"CALC_STRESS",lines) == ['CALC_STRESS']:
            stress_flag = int(re.findall(r'\d+',lines)[0])  
    return stress_flag


def getMesh(file):    
    fd_grid = []
    cell = []

    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    for lines in f_out_content:
        if re.findall(r"FD_GRID",lines) == ['FD_GRID']:
            temp = re.findall(r'\d+ \d+ \d+',lines)[0].split(" ")
            fd_grid = [int(i) for i in temp]            
        if re.findall(r"CELL",lines) == ['CELL']:
            temp = re.findall(r'\d+\.\d+ \d+\.\d+ \d+\.\d+',lines)[0].split(" ")
            cell = [float(i) for i in temp]            

    fd_grid = np.array(fd_grid)
    cell = np.array(cell)
    mesh = cell/fd_grid
    mesh = np.sqrt(np.mean(mesh**2))
    return mesh

def getMesh_input(file):    
    mesh = -1
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    for lines in f_out_content:
        if re.findall(r"MESH_SPACING",lines) == ['MESH_SPACING']:
            mesh = float(re.findall(r'\d+\.\d+',lines)[0])            
    return mesh


def getFdgrid(file):    
    fd_grid = []

    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    for lines in f_out_content:
        if re.findall(r"FD_GRID",lines) == ['FD_GRID']:
            temp = re.findall(r'\d+ \d+ \d+',lines)[0].split(" ")
            fd_grid = [int(i) for i in temp]                  

    fd_grid = np.array(fd_grid)
    return fd_grid

def getCell(file):    
    cell = []
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    for lines in f_out_content: 
        if re.findall(r"CELL",lines) == ['CELL']:
            temp = re.findall(r'\d+\.\d+ \d+\.\d+ \d+\.\d+',lines)[0].split(" ")
            cell = [float(i) for i in temp]            
    cell = np.array(cell)
    return cell


def check_INF_NAN(file):
    flag = 0
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    for lines in f_out_content:
        if re.findall(r"INF",lines) == ['INF']:
            flag = 1            
        if re.findall(r"NAN",lines) == ['NAN']:
            flag = 1
    return flag


def find_err(outname,staname,Ebench,Fbench):    
    natom = getNatom(outname)
    E = getEnergy(outname)
    F = getForce(staname,natom)
    wtime = getWalltime(outname)
    Eerr = np.absolute(E - Ebench)        
    Ferr = np.absolute(F - Fbench).max()
    return Eerr,Ferr,wtime


def find_indx():
    files = [f for f in os.listdir('.') if os.path.isfile(f)]
    indx = -1
    for f in files:
        if f.find(".out") > -1:
            indx = indx + 1
    return indx


def perturb_atoms(staname):
    rd.seed(10)
    natom = []
    typ_count = 0
    pos =[]
    with open(staname,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    
    flag = 0
    for idx,lines in enumerate(f_out_content):
        if lines.startswith("#"):
            continue
        if re.findall(r"N_TYPE_ATOM",lines) == ['N_TYPE_ATOM']:            
            natom.append(int(re.findall(r'[+-]?\d+',lines)[0]))
            typ_count = typ_count + 1            
        if re.findall(r"COORD_FRAC",lines) == ['COORD_FRAC']:
            flag = natom[typ_count-1]
            continue
        if flag > 0:            
            temp = re.findall(r'[+-]?\d+\.\d+',lines)            
            postemp = [float(i)+0.1*(rd.random()-0.5) for i in temp] 
            posstr = str(postemp[0]) + '   ' + str(postemp[1]) + '   ' + str(postemp[2])            
            f_out_content[idx] = posstr                  
            flag = flag - 1
    
    with open(staname, 'w') as file:
        for lines in f_out_content:
            file.write("%s\n" % lines)


def getNscf(file):
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    for lines in f_out_content:
        if re.findall(r"Total number of SCF",lines) == ['Total number of SCF']:
            nscf = int(re.findall(r'\d+',lines)[0])
    return nscf


def getSCFerr(file,Nscf):
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    
    flag = 0
    scf_err = np.zeros(Nscf)
    for lines in f_out_content:
        if flag > 0 and flag <= Nscf:            
            scf_err[flag-1] = float(re.findall(r'[+-]?\d+\.\d+[E][+-]\d+',lines)[1])             
            flag = flag+1
        if re.findall(r"Iteration     Free Energy",lines) == ['Iteration     Free Energy']:
            flag = 1
    return scf_err


def getEnergyPerStep(file,Nscf):
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    
    flag = 0
    Elist = np.zeros(Nscf)
    for lines in f_out_content:
        if flag > 0 and flag <= Nscf:            
            Elist[flag-1] = float(re.findall(r'[+-]?\d+\.\d+[E][+-]\d+',lines)[0])             
            flag = flag+1
        if re.findall(r"Iteration     Free Energy",lines) == ['Iteration     Free Energy']:
            flag = 1
    return Elist

def getFinalSCFerror(file,Nscf):
    with open(file,'r') as f_out:
        f_out_content = [ line.strip() for line in f_out ]
    
    flag = 0
    final_scf_err = 0
    for lines in f_out_content:
        if flag > 0:
            flag = flag+1
        if flag == Nscf:            
            final_scf_err = float(re.findall(r'[+-]?\d+\.\d+[E][+-]\d+',lines)[1])             
        if re.findall(r"Iteration     Free Energy",lines) == ['Iteration     Free Energy']:
            flag = 1
    return final_scf_err