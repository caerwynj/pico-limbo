
include "sys.m";
sys: Sys;
sleep, open, write, read, aprint, print, sprint, fildes, fprint: import sys;
include "draw.m";
include "string.m";
str: String;
tobig, toint, toreal, tolower, toupper: import str;
include "bufio.m";
bufio: Bufio;
Iobuf: import bufio;

Command:module
{ 
	init:fn(ctxt: ref Draw->Context, argv: list of string); 
};

ctxt: ref Draw->Context;

init(c: ref Draw->Context, argv: list of string)
{
	sys = load Sys Sys->PATH;
	str = load String String->PATH;
	bufio = load Bufio Bufio->PATH;
	ctxt = c;
	main(argv);
}
