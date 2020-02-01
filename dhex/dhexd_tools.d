/**
 * dhexd_tools.d
 * tools for an hexdump in D
 *
 * Authors: Bernard Tatin, bernard.tatin@outlook.fr
 */

module dhexd_tools;

/// byte value of space; chars before space are not printable 
private const ubyte CH_WHITE = 32;
/// byte value of the first ugly char; chars after this value are not printable 
private const ubyte CH_UGLY = 126;

/**
	transform an unsigned byte in a printable char;

	not sure that immutable is really useful here
	but I had to try it at least once

	Params:
		b = the ubyte to transform

	Returns:
		a dot for non printable chars, else, the char
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
