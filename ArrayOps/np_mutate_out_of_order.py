import numpy as np

a = np.array([1,2,3,4,5])

indices = [2,4,1]

print a[indices] # [3 5 2]
a[indices] = [7,8,9]
print a # [1 9 7 4 8]