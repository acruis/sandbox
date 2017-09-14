import random

def insertion_sort(a):
	for curr_index in range(1, len(a)):
		search_index = curr_index
		while search_index > 0:
			if a[search_index] < a[search_index - 1]:
				temp = a[search_index]
				a[search_index] = a[search_index - 1]
				a[search_index - 1] = temp
				search_index = search_index - 1
			else:
				break

a = [int(100 * random.random()) for _ in range(10)]
print a
insertion_sort(a)
print a