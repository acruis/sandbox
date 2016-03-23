import time
import os

def test_file(op):
	to_read = file("written")
	before = time.time() * 1000
	op(to_read)
	after = time.time() * 1000
	to_read.close()
	print(after - before)

def read_fast(to_read):
	fast = to_read.read(5000000)

def read_slow(to_read):
	for i in range(5000000):
		to_read.read(1)

to_write = file("written", 'w')

for i in range(1000000):
	to_write.write("thing")

to_write.close()

test_file(read_fast)
test_file(read_slow)

os.remove("written")