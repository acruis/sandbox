a = 10

def assign_or_mutate():
	a = 5

print a # 10
assign_or_mutate()
print a # Still 10. a is only assigned, not mutated.