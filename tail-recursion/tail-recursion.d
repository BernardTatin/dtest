/*
 * tail-recursion.d
 * testing tail-recursion in D
 *
 * first attempt: no tail recursion in dmc and ldc2
 */

module tail_recursion;

import std.stdio: writef, writefln;

pure auto tail_recursion(immutable int n) {
	/*
	if (n % 1000 == 0) {
		writefln("%8d", n);
	}
	*/
	if (n < 0) {
		return n;
	/* } else if (n > 100000) {
		return n; */
	} else {
		return tail_recursion(n + 1);
	}
}

void main() {
	writefln("--> %d", tail_recursion(0));
}