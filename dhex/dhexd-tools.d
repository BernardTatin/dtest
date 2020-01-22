/*
 * dhexd-tools.d
 */

module dhexd_tools;

pure char byte2char(ubyte b) {
	char c;

	if (b < 32 || b > 127) {
		c = '.';
	} else {
		c = cast(char)b;
	}
	return c;
}
