_CC := clang
CFLAGS =

ifneq '$(CC)' ''
	_CC := $(CC)
endif

all: wrapper.o

wrapper.o:
	$(_CC) $(CFLAGS) -c -o src/lib_ncurses/wrapper.o src/lib_ncurses/wrapper.c

clean:
	rm -f src/lib_ncurses/wrapper.o
