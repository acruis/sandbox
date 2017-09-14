import random

def selection_sort(a):
	for curr_index in range(len(a) - 1):
		minimum = a[curr_index]
		minimum_index = curr_index
		for search_index in range(curr_index + 1, len(a)):
			if a[search_index] < minimum:
				minimum = a[search_index]
				minimum_index = search_index
		temp = a[curr_index]
		a[curr_index] = a[minimum_index]
		a[minimum_index] = temp

a = [int(100 * random.random()) for _ in range(10)]
print a
selection_sort(a)
print a
