def binary_search(a, q):
	"""
	If end > start + 1, (end + start) / 2 > (2*start + 1) / 2 = start + 1/2
	Also, (end + start) / 2 < (2*end - 1) / 2 = end - 1/2
	-> end > curr_index > start.
	If end = start + 1, (end + start) / 2 = start.
	If end = start, curr_index = start.
	Hence start never goes past end without first becoming equal to end.
	"""

	start = 0
	end = len(a) - 1

	while start <= end:
		curr_index = (start + end) / 2
		if a[curr_index] > q:
			end = curr_index - 1
		elif a[curr_index] < q:
			start = curr_index + 1
		else:
			return curr_index

	if start > end:
		return -1

a = [2,3,4]
for q in range(6):
	print binary_search(a, q)
