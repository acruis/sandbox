from math import pow as mpow

a = 100.

def plain_mult():
	for _ in range(100000000):
		a = 10. * 10.

def plain_pow():
	for _ in range(100000000):
		a = pow(10.,2)

def math_pow():
	for _ in range(100000000):
		a = mpow(10., 2)

def starstar():
	for _ in range(100000000):
		a = 10. ** 2

# plain_mult() # 11.593s
# plain_pow() # 20.285s
# math_pow() # 19.699s
starstar() # 8.276s