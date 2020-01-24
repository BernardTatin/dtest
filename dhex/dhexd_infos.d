/*
 * dhexd_infos.d
 * hexdump in D
 */

module dhexd_infos;


import std.stdio: writef, writefln, File, chunks;
import core.stdc.stdlib: exit;

const string app_version = "0.2.2";


void on_help(string progname) {
	writef("%s [-h|--help]: show this text and exits\n", progname);
	writef("%s [-v|--version]: show version and exits\n", progname);
	writef("%s [OPTIONS] file ...: show the hexdump of all files\n", progname);
	writef("OPTIONS:\n");
	writef("  -q|--quiet: don't show file names\n");
	exit(0);
}
void on_version(string progname) {
	writef ("%s version %s\n", progname, app_version);
	exit(0);
}
