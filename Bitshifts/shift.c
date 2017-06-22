#include <stdio.h>

int main() {
	int c = -101;
	int b = (int)(((unsigned int)c) << 16);
	printf("%d\n", c); // -101
	printf("%d\n", b); // -6619136; still negative
	return 0;
}