#!/usr/bin/env python
import os
import sys
import string
import StringIO
import re

'''This is a fairly hacky script to take an input alignment file
and output a copy of it, but with a dummy taxon ROOT added.
'''

if len(sys.argv) == 2:
    filename = sys.argv[1]
    file = open(filename, 'rU')
else:
    print "usage\naddROOT.py <filename>"
    exit()

startedMatrix = False
lastLine = ""
while True:
    line = file.readline()
    if not line:
        break
    line = line.rstrip()
    
    if not startedMatrix and "matrix" in line.lower():
        startedMatrix = True
    
    elif startedMatrix and ";" in line.lower():
        #if we just reached the end of a matrix, indicated by a ;, 
        #take the last listed sequence and make a new taxon and
        #sequence named ROOT
        root = lastLine.split()
        root[0] = "ROOT"
        root[1] = re.sub("[A-Za-z01]","?", root[1])
        print "%s\t%s" % (root[0], root[1])
        startedMatrix = False
    
    elif "ntax" in line.lower():
        #strip out ='s
        splt = re.sub('=', ' ', line.lower().rstrip(';'))
        splt = splt.split()
        index = 0
        #the number of taxa should now be the first thing following ntax
        while ((index < len(splt) - 1) and not "ntax" in splt[index]):
            index = index + 1
        ntax = int(splt[index + 1])
        line = re.sub(str(ntax), str(ntax + 1), line)
    
    elif "taxlabels" in line.lower():
        #add ROOT to the taxlabels, if present
        line = re.sub(";", " ROOT;", line)
    
    elif not re.search("^tree", line.lower()) == None:
        #add ROOT to any trees, if present
        line = re.sub("\);", ",ROOT:0.01);", line)
        
    print line
    lastLine = line
    
