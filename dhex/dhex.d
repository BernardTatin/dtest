/**
 * dhexd.d
 * hexdump in D
 *
 * Authors: Bernard Tatin, bernard.tatin@outlook.fr
 */

module dhexd;

import std.algorithm.iteration: reduce, map;
import std.file: exists, isFile;
import std.stdio: writef, writefln, File, chunks;
import std.format: sformat;

import dhexd_tools;
import dhexd_infos;

/// size of hexedump line and of buffer to read input file
const int chunck_size = 16;
/// before and after the ASCII part
const char separator = '|';
/// print or don't print file names and more
bool quiet = false;

/**
 do the hexdump
 params:
	the file_name
 */
void wrap_on_file(immutable(string) file_name) {
	void on_file() {
		auto byte2string(immutable(ubyte) a) {
			static char[3]  hbuf;
			return  cast(string)sformat(hbuf[], "%02x ", a);
		}
		pure string concat_strings(immutable(string) a, immutable(string) b) {
			return a ~ b;
		}
		auto f = File(file_name, "r");
		int address = 0;

		foreach (ubyte[] buffer; chunks(f, chunck_size)) {
			immutable int buffer_len = cast(int)buffer.length;
			writef ("%08x %s", address,
				reduce!((a, b) => concat_strings(a, b))("", buffer.map!(a => byte2string(a))));
			address += buffer_len;
			if (buffer_len < chunck_size) {
				int d = chunck_size - buffer_len;
				foreach (_; 0 .. d) {
					writef("   ");
				}
			}
			writef(" %c%s%c\n", separator,
				buffer.map!(a => byte2char(a)),
				separator);
		}
		writef("%08x\n", address);
	}


	if (!exists(file_name) || !isFile(file_name)) {
		writefln ("-> ERROR: %s is not a file", file_name);
	} else {
		if (!quiet) {
			writefln("-> %s", file_name);
		}
		on_file ();
	}
}

void main(string[] args) {
	bool isInOptions = true;
	immutable string progname = args[0];

	if (args.length == 1) {
		on_help(progname);
	}
	foreach (string a; args[1..$]) {
		if (isInOptions) {
			switch (a) {
				case "-h":
				case "--help":
					on_help(progname);
					break;
				case "-v":
				case "--version":
					on_version(progname);
					break;
				case "-q":
				case "--quiet":
					quiet = true;
					break;
				default:
					isInOptions = false;
					wrap_on_file(a);
					break;
			}
		} else {
			wrap_on_file(a);
		}
	}
}
