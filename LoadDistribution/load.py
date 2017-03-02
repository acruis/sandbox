import sys
from math import floor, ceil

p = int(sys.argv[1])
x = float(sys.argv[2])

m = x % p

def make0toinf(i):
	return floor( (i + 1) / (m + 1) )

def make0to1(i):
	return ceil( make0toinf(i) / (make0toinf(i) + 1) )

def k(i):
	return ceil( x / p ) - make0to1(i)

print [k(i) for i in range(p)]