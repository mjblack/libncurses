CC = clang
# CFLAGS needs to include ncurses includes
CFLAGS =
#LDFLAGS needs to include NCurses
LDFLAGS = -lncurses -lmenu
#Crystal flags
CRFLAGS =

EXAMPLES = hello_world menu1 menu2

all: $(EXAMPLES)
.PHONY: all

hello_world:
	${CC} hello_world.c -o hello_world-c ${CFLAGS} ${LDFLAGS}
	crystal build -o hello_world-cr ${CRFLAGS} hello_world.cr

menu1:
	${CC} menu1.c -o menu1-c ${CFLAGS} ${LDFLAGS}
	crystal build -o menu1-cr ${CRFLAGS} menu1.cr

menu1:
	${CC} menu2.c -o menu2-c ${CFLAGS} ${LDFLAGS}
	crystal build -o menu1-cr ${CRFLAGS} menu2.cr

clean:
	rm *-c *-cr *.dwarf
