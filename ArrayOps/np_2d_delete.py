import numpy as np

a = [np.array([1,2,3]), np.array([5,6])]
a[0] = a[0][a[0] != 2]

print a[0] # [1 3]
print a[1] # [5 6]