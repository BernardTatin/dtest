/*
 * hello-stdin.d
 * code from https://dlang.org/library/std/stdio/stdin.html
 * compile:
 *      dmc hello-stdin.d -of=hello-stdin.exe
 * test:
 *      cat <file> | ./hello-stdin.exe
 */

module hello_stdin;

import std.stdio; // Read stdin, sort lines, write to stdout
import std.algorithm.mutation : copy;
import std.algorithm.sorting : sort;
import std.array : array;
import std.typecons : Yes;

void main()
{
    stdin                       // read from stdin
    .byLineCopy(Yes.keepTerminator) // copying each line
    .array()                    // convert to array of lines
    .sort()                     // sort the lines
    .copy(                      // copy output of .sort to an OutputRange
        stdout.lockingTextWriter()); // the OutputRange
}
