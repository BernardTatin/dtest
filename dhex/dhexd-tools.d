/*
 * dhexd-tools.d
 */

module dhexd_tools;

const ubyte CH_WHITE = 32;
const ubyte CH_UGLY = 126;
/*
	not sure that immutable is really useful here
	but I had to try it at least once
 */
pure char byte2char(immutable ubyte b) {
	char c;

	if (b < CH_WHITE || b > CH_UGLY) {
		c = '.';
	} else {
		c = cast(char)b;
	}
	return c;
}
