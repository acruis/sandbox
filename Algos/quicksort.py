import random

def quicksort(a, left, right):
	if left >= right:
		return

	i = left + 1
	j = right

	while True:
		while i < right and a[i] < a[left]:
			i = i + 1
		while j > left and a[j] >= a[left]:
			j = j - 1

		if i >= j:
			break

		temp = a[i]
		a[i] = a[j]
		a[j] = temp

	temp = a[left]
	a[left] = a[j]
	a[j] = temp	

	quicksort(a, left, j - 1)
	quicksort(a, j + 1, right)

a = [int(100 * random.random()) for _ in range(9)]
print a
quicksort(a, 0, 8)
print a