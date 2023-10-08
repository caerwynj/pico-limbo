implement Command;
include "cmd.m";

stdout: ref Sys->FD;
stdin: ref Sys->FD;
gpio: ref Sys->FD;

pin := 16;
WAITMS : con 80;
NBUF: con  100;


main(argv: list of string)
{
	buf := array[NBUF] of byte;

	argv = tl argv;
	if(argv == nil) {
		print("blink pin\n");
		return;
	}
	(pin, nil) = toint(hd argv, 10);

	f := open("/dev/gpio", Sys->ORDWR);
	if (f == nil) {
		print("can't open gpio file\n");
		gpio = fildes(1);
	}else
		gpio = f;

	stdin = fildes(0);

	func := aprint("function %d out\n", pin);

	write(gpio, func, len func);

	for(;;) {
		n := read(stdin, buf, NBUF);
		if (n <= 0)
			return;
		for (i := 0; i < n; i++) {
			c := int buf[i];
			if (c == '.')
				dot();
			else if (c == '-')
				dash();
			else if (c == ' ' || c == '\n')
				sleep(WAITMS);
		}
	}
}

led(v: int)
{
	fprint(gpio, "set %d %d\n", pin, v);
}

dot()
{
	led(1);
	sleep(WAITMS);
	led(0);
	sleep(WAITMS);
}

dash()
{
	led(1);
	sleep(WAITMS*3);
	led(0);
	sleep(WAITMS);
}