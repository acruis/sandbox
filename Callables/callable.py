from math import exp

class SquaredExponentialKernel:
	def __init__(self, length, amplitude):
		self.length = length
		self.amplitude = amplitude

	def __call__(self, x1, x2):
		amp_portion = self.amplitude * self.amplitude
		distance_portion = (x1 - x2) / self.length
		exp_portion = exp( (-0.5) * (distance_portion ** 2) )
		return amp_portion * exp_portion

kern = SquaredExponentialKernel(4.0, 1.0)
print kern(1.0, 16.0) # 0.000883826306935
kern.length = 8.0
print kern(1.0, 16.0) # 0.172421623894