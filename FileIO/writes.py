import os

to_write = file("written", 'w')

for i in range(10):
	to_write.write(str(i))
	print to_write.tell()

to_write.close()

os.remove("written")