

SRC	= SoCLib.c SoCHelper.c GA.c main.c
main: $(SRC)
	gcc -ggdb3 -O1 -std=c99 $(SRC) -o main

run:	main
	sudo ./main
program:
	sudo dd if=BitCounterFix.rbf of=/dev/fpga0
