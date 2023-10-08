implement Command;
include "cmd.m";

main(argv: list of string)
{
	pin := 16;

	argv = tl argv;
	if(argv == nil) {
		print("blink pin\n");
		return;
	}
	(pin, nil) = toint(hd argv, 10);

	f := open("#G/gpio", Sys->ORDWR);
	if (f == nil) {
		print("can't open file");
		return;
	}

	func := aprint("function %d out\n", pin);
	up := aprint("pullup %d\n", pin);
	down := aprint("pulldown %d\n", pin);

	write(f, func, len func);
	for (i := 0; i < 100; i++) {
		write(f, up, len up);
		print("blink %d\n", pin);
		sleep(1000);
		write(f, down, len down);
	}
}
