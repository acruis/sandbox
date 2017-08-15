import numpy as np

a = np.array(range(500))
x = a[457]
assert a[457] == 457

def list_comprehension():
	for _ in range(100000):
		a_deleted = [a_i for a_i in a if a_i != x]
		assert a_deleted[457] == 458

def np_argwhere_delete():
	for _ in range(100000):
		index = np.argwhere(a == x)
		a_deleted = np.delete(a, index)
		assert a_deleted[457] == 458

def np_nonzero_delete():
	for _ in range(100000):
		index = np.nonzero(a == x)[0]
		a_deleted = np.delete(a, index)
		assert a_deleted[457] == 458

def boolean_mask():
	# Not exactly a deletion, but uses boolean mask indexing
	for _ in range(100000):
		a_deleted = a[a != x]
		assert a_deleted[457] == 458

# list_comprehension() # 7.302s
# np_argwhere_delete() # 3.392s
# np_nonzero_delete() # 2.415s
boolean_mask() # 0.419s