import numpy as np

def mutate_indirectly():
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
# mutate_indirectly()

def list_declare():
	for _ in range(10000):
		x = range(100000)
# list_declare() # 13.918s

def list_extract():
	for _ in range(10000):
		x = range(100000)
		y = x[:-56]
# list_extract() # 23.0s

def list_mutate():
	for _ in range(10000):
		x = range(100000)
		y = x[:-56]
		y[20000] = 45
# list_mutate() # 23.3s

def np_list_convert():
	for _ in range(10000):
		x = np.array(range(100000))
# np_list_convert() # 58.2s

def np_list_extract():
	for _ in range(10000):
		x = np.array(range(100000))
		y = x[:-56]
# np_list_extract() # 58.3s

def np_list_mutate():
	for _ in range(10000):
		x = np.array(range(100000))
		y = x[:-56]
		y[20000] = 45
# np_list_mutate() # 58.3s

def np_arange_mutate():
	for _ in range(10000):
		x = np.arange(100000)
		y = x[:-56]
		y[20000] = 45
np_arange_mutate() # 0.568s