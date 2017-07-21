#!/usr/bin/env python

import sys

import dendropy
from dendropy.calculate import treecompare
tns = dendropy.TaxonNamespace()

tree1 = dendropy.Tree.get_from_path(sys.argv[1],
	                       sys.argv[2],
	                       taxon_namespace=tns)
tree2 = dendropy.Tree.get_from_path(sys.argv[3],
	                                sys.argv[4],
                                    taxon_namespace=tns)

#Weighted RF
print(dendropy.calculate.treecompare.unweighted_robinson_foulds_distance(tree1, tree2))

#RF
print(dendropy.calculate.treecompare.weighted_robinson_foulds_distance(tree1, tree2))