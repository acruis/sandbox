import numpy as np

a = np.array([1,2,3,4,5])
b = a[a != 4]
print b # [1 2 3 5]
b[3] = 9
print b # [1 2 3 9]
print a # [1 2 3 4 5]
b[-1] = 9
print b # [1 2 3 9]
print a # [1 2 3 4 5]

# a does not get mutated!