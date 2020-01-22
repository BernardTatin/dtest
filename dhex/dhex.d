/*
 * dhexd.d
 * hexdump in D
 ***
 $ rm -fv *.obj *.exe
 $ dmd dhexd-tools.d dhex.d -of=dhex.exe \
 	&& ./dhex.exe dhexd-tools.obj *.md
 ***
 */

module dhexd;

import std.stdio,
		std.file,
		std.algorithm.iteration,
		std.format,
		dhexd_tools;

const string app_version = "0.2.1";
const int chunck_size = 16;
const char separator = '|';

void on_file(string file_name) {
	auto f = File(file_name, "r");
	int address = 0;
	char[3]  hbuf;

	foreach (ubyte[] buffer; chunks(f, chunck_size)) {
		writef ("%08x: %s", address,
			reduce!((a, b) => a ~ b)("", buffer.map!(a => cast(string)sformat(hbuf[], "%02x ", a))));
		address += chunck_size;
		if (buffer.length < chunck_size) {
			int d = chunck_size - buffer.length;
			foreach (_; 0 .. d) {
				writef("   ");
			}
		}
		writef(" %c%s%c\n", separator,
			buffer.map!(a => byte2char(a)),
			separator);
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
