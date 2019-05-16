

SRC	= SoCLib.c SoCHelper.c GA.c main.c
main: $(SRC)
	gcc -std=c99 $(SRC) -o main

run:	SoCtest
	sudo ./main

