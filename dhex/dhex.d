/*
 * dhexd.d
 * hexdump in D
 */

module dhexd;

import std.stdio,
		std.file;

string app_version = "0.1.1";
int chunck_size = 16;

void on_file(string file_name) {
	auto f = File(file_name, "r");
	int address = 0;

	foreach (ubyte[] buffer; chunks(f, chunck_size)) {
		writef ("%08x: ", address);
		address += chunck_size;
		foreach (b; buffer) {
			writef ("%02x ", b);
		}
		writef("\n");
	}
}

void main(string[] args) {
	writefln("dhexd %s\n", app_version);
	writefln("prog name: %s", args[0]);
	foreach (string a; args[1..$]) {
		writefln("-> %s", a);
		if (!exists(a) || !isFile(a)) {
			writefln ("-> ERROR: %s is not a file", a);
		} else {
			writefln ("-> SUCCESS: %s is a file!!!", a);
			on_file (a);
		}
	}
}
