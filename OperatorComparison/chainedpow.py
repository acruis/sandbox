a = 1.5

def chainedpow():
	for _ in range(50000000):
		a = 1.5 ** 2
		a = a ** 3

def straightpow():
	for _ in range(50000000):
		a = 1.5 ** 6

# chainedpow() # 7.864s
straightpow() # 3.442s