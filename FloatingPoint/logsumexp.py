"""
Checks the validity of LogSumExp in normalizing very small exponents.

Sometimes the renormalized probabilities do not sum up to 1 (the last
printed line) but only very close to 1 (e.g. 0.999999999997 or 1.00000000001)
because scaling the log proportions (log_props - 200000.) causes precision
loss.
"""

from scipy.misc import logsumexp
import numpy as np

class format:
	# https://stackoverflow.com/a/17303428
	BOLD = '\033[1m'
	END = '\033[0m'

	@staticmethod
	def bold(s):
		return format.BOLD + s + format.END

k = 6

# Generate k proportions summing up to 1

proportions = np.random.rand(k)
proportions = proportions / proportions.sum()
print format.bold("Proportions"), proportions

# Take their logs

log_props = np.log(proportions)
print format.bold("Logprops"), log_props

# Scale down proportions by a common factor

scaled_log_props = log_props - 200000.
print format.bold("Scaled log props"), scaled_log_props

# Get the LogSumExp

normalizing_constant = logsumexp(scaled_log_props)
print format.bold("Normalizing constant"), normalizing_constant # Should be exactly -200000.

# Add the normalizing constant back

unscaled_log_props = scaled_log_props - normalizing_constant
unscaled_props = np.exp(unscaled_log_props)
should_be_1 = unscaled_props.sum()
print format.bold("Should be 1"), should_be_1