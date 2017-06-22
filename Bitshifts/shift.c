#include <stdio.h>

int main() {
	int c = -101;
	int b = (int)(((unsigned int)c) << 16);
	printf("%d\n", c);
	printf("%d\n", b);
	return 0;
}