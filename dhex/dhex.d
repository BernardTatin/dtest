/*
 * dhexd.d
 * hexdump in D
 */

module dhexd;

import std.stdio;

string app_version = "0.1.0";

void main(string[] args) {
	writefln("dhexd %s\n", app_version);
	writefln("prog name: %s", args[0]);
	foreach (string a; args[1..$]) {
		writefln("-> %s", a);
	}
}
