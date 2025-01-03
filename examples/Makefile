_CC = #clang
# CFLAGS needs to include ncurses includes
_CFLAGS =
#LDFLAGS needs to include NCurses
_LDFLAGS = -lncurses -lmenu
#Crystal flags
_CRFLAGS = 
#Crystal linker flags
_CRLDFLAGS =

ifneq '$(CC)' ''
	_CC := $(CC)
endif

ifneq '$(CFLAGS)' ''
	_CFLAGS := $(CFLAGS)
endif

ifneq '$(LDFLAGS)' ''
	_LDFLAGS := $(LDFLAGS)
endif

ifneq '$(CRLDFLAGS)' ''
	_CRFLAGS := --link-flags "$(CRLDFLAGS)"
endif

ifneq '$(CRFLAGS)' ''
	_CRFLAGS := $(CRFLAGS)
endif

EXAMPLES = hello_world menu1 menu2

all: $(EXAMPLES)
.PHONY: all

hello_world:
	$(_CC) hello_world.c -o hello_world-c $(_CFLAGS) $(_LDFLAGS)
	crystal build -o hello_world-cr $(_CRFLAGS) $(_CRLDFLAGS) hello_world.cr

menu1:
	$(_CC) menu1.c -o menu1-c $(_CFLAGS) $(_LDFLAGS)
	crystal build -o menu1-cr $(_CRFLAGS) $(_CRLDFLAGS) menu1.cr

menu2:
	$(_CC) menu2.c -o menu2-c $(_CFLAGS) $(_LDFLAGS)
	crystal build -o menu2-cr $(_CRFLAGS) $(_CRLDFLAGS) menu2.cr

clean:
	rm *-c *-cr *.dwarf
