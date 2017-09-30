import numpy as np

def single_argument_function(x):
	return x ** 2

a = [x for x in range(10000)]

def list_comprehension(a):
	for _ in range(5000):
		b = [single_argument_function(x) for x in a]

vectorized_single_argument_function = np.vectorize(single_argument_function)
def vectorized(a):
	for _ in range(5000):
		b = vectorized_single_argument_function(a)

# vectorized(a) # 15.72s
list_comprehension(a) # 16.08s