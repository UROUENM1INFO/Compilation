SHELL = /bin/bash
LEX = flex
LFLAGS = -D_POSIX_SOURCE -o $@ -DYY_NO_INPUT --nounput
CC = gcc
CFLAGS = -std=c99 -pedantic -Wall
LDFLAGS = -lfl 

%: %.o
	$(CC) -o $@ $< $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $<

%.c: %.l
	$(LEX) $(LFLAGS) $<

clean:
	-rm *.o *.c $(EXEC)