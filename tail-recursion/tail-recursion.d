/*
 * tail-recursion.d
 * testing tail-recursion in D
 *
 * usage:
 	$ dmd|ldc2 tail-recursion.d -of=tail-recursion.exe \
 		&& ./tail-recursion.exe

 * first attempt: no tail recursion in dmc and ldc2
 */

module tail_recursion;

import std.stdio: writef, writefln;

pure auto tail_recursion(immutable(int) n) {
	if (n < 0) {
		return n;
	} else {
		return tail_recursion(n + 1);
	}
}

void main() {
	writefln("--> %d", tail_recursion(0));
}