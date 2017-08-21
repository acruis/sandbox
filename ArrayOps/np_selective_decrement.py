import numpy as np

a = np.array([1,3,3,1,1,1,1,3,1,1], dtype=int)

print a # [1 3 3 1 1 1 1 3 1 1]

a[a == 1] = a[a == 1] - 1

print a # [0 3 3 0 0 0 0 3 0 0]

a[a == 3] = a[a == 3] - 1

print a # [0 2 2 0 0 0 0 2 0 0]

a[a > 0] = a[a > 0] - 1

print a # [0 1 1 0 0 0 0 1 0 0]

b = np.array([1,3,3,1,4,1,5,3,1,4], dtype=int)

print b # [1 3 3 1 4 1 5 3 1 4]

b[b > 2] = b[b > 2] - 1

print b # [1 2 2 1 3 1 4 2 1 3]