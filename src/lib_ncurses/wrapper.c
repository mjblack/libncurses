#ifndef NCURSES_WIDECHAR
#define NCURSES_WIDECHAR 1
#endif

#include <ncursesw/ncurses.h>

#ifndef NCURSES_VERSION
#define NCURSES_VERSION "Unknown"

/*
 * NetBSD Curses only defines this as a macro
 */

int (COLOR_PAIR)(int n) {
	return COLOR_PAIR(n);
}
#endif


/* 
 * TODO: something better here
 */

int color_pair(int n) {
	return COLOR_PAIR(n);
}

bool impl_mouse_trafo(int *y, int *x, bool to_screen) {
	return wmouse_trafo(stdscr, y, x, to_screen);
}

typedef struct version {
	int major;
	int minor;
	int patch;
} version;

void get_ncurses_version(version *v) {
	v->major = NCURSES_VERSION_MAJOR;
	v->minor = NCURSES_VERSION_MINOR;
	v->patch = NCURSES_VERSION_PATCH;
	return;
}

char *ncurses_version() {
  char *version;
  version = NCURSES_VERSION;
	return version;
}



int impl_NCURSES_MOUSE_VERSION() { return NCURSES_MOUSE_VERSION; }

int impl_A_NORMAL() { return A_NORMAL; }
int impl_A_ATTRIBUTES() { return A_ATTRIBUTES; }
int impl_A_CHARTEXT() { return A_CHARTEXT; }
int impl_A_COLOR() { return A_COLOR; }
int impl_A_STANDOUT() { return A_STANDOUT; }
int impl_A_UNDERLINE() { return A_UNDERLINE; }
int impl_A_REVERSE() { return A_REVERSE; }
int impl_A_BLINK() { return A_BLINK; }
int impl_A_DIM() { return A_DIM; }
int impl_A_BOLD() { return A_BOLD; }
int impl_A_ALTCHARSET() { return A_ALTCHARSET; }
int impl_A_INVIS() { return A_INVIS; }
int impl_A_PROTECT() { return A_PROTECT; }
int impl_A_HORIZONTAL() { return A_HORIZONTAL; }
int impl_A_LEFT() { return A_LEFT; }
int impl_A_LOW() { return A_LOW; }
int impl_A_RIGHT() { return A_RIGHT; }
int impl_A_TOP() { return A_TOP; }
int impl_A_VERTICAL() { return A_VERTICAL; }

/*
 * ACS_ values aren't set until after `init_scr` 
 */

unsigned int impl_NCURSES_ACS(unsigned char c) { return NCURSES_ACS(c); }

unsigned int impl_ACS_ULCORNER() { return ACS_ULCORNER; }
unsigned int impl_ACS_LLCORNER() { return ACS_LLCORNER; }
unsigned int impl_ACS_URCORNER() { return ACS_URCORNER; }
unsigned int impl_ACS_LRCORNER() { return ACS_LRCORNER; }
unsigned int impl_ACS_LTEE() { return ACS_LTEE; }
unsigned int impl_ACS_RTEE() { return ACS_RTEE; }
unsigned int impl_ACS_BTEE() { return ACS_BTEE; }
unsigned int impl_ACS_TTEE() { return ACS_TTEE; }
unsigned int impl_ACS_HLINE() { return ACS_HLINE; }
unsigned int impl_ACS_VLINE() { return ACS_VLINE; }
unsigned int impl_ACS_PLUS() { return ACS_PLUS; }
unsigned int impl_ACS_S1() { return ACS_S1; }
unsigned int impl_ACS_S9() { return ACS_S9; }
unsigned int impl_ACS_DIAMOND() { return ACS_DIAMOND; }
unsigned int impl_ACS_CKBOARD() { return ACS_CKBOARD; }
unsigned int impl_ACS_DEGREE() { return ACS_DEGREE; }
unsigned int impl_ACS_PLMINUS() { return ACS_PLMINUS; }
unsigned int impl_ACS_BULLET() { return ACS_BULLET; }
unsigned int impl_ACS_LARROW() { return ACS_LARROW; }
unsigned int impl_ACS_RARROW() { return ACS_RARROW; }
unsigned int impl_ACS_DARROW() { return ACS_DARROW; }
unsigned int impl_ACS_UARROW() { return ACS_UARROW; }
unsigned int impl_ACS_BOARD() { return ACS_BOARD; }
unsigned int impl_ACS_LANTERN() { return ACS_LANTERN; }
unsigned int impl_ACS_BLOCK() { return ACS_BLOCK; }
unsigned int impl_ACS_S3() { return ACS_S3; }
unsigned int impl_ACS_S7() { return ACS_S7; }
unsigned int impl_ACS_LEQUAL() { return ACS_LEQUAL; }
unsigned int impl_ACS_GEQUAL() { return ACS_GEQUAL; }
unsigned int impl_ACS_PI() { return ACS_PI; }
unsigned int impl_ACS_NEQUAL() { return ACS_NEQUAL; }
unsigned int impl_ACS_STERLING() { return ACS_STERLING; }
unsigned int impl_ACS_BSSB() { return ACS_BSSB; }
unsigned int impl_ACS_SSBB() { return ACS_SSBB; }
unsigned int impl_ACS_BBSS() { return ACS_BBSS; }
unsigned int impl_ACS_SBBS() { return ACS_SBBS; }
unsigned int impl_ACS_SBSS() { return ACS_SBSS; }
unsigned int impl_ACS_SSSB() { return ACS_SSSB; }
unsigned int impl_ACS_SSBS() { return ACS_SSBS; }
unsigned int impl_ACS_BSSS() { return ACS_BSSS; }
unsigned int impl_ACS_BSBS() { return ACS_BSBS; }
unsigned int impl_ACS_SBSB() { return ACS_SBSB; }
unsigned int impl_ACS_SSSS() { return ACS_SSSS; }

/*
 * WACS_ values aren't set until after `init_scr`
 */

cchar_t* impl_NCURSES_WACS(unsigned char c) { return NCURSES_WACS(c); }

cchar_t* impl_WACS_ULCORNER() { return WACS_ULCORNER; }
cchar_t* impl_WACS_LLCORNER() { return WACS_LLCORNER; }
cchar_t* impl_WACS_URCORNER() { return WACS_URCORNER; }
cchar_t* impl_WACS_LRCORNER() { return WACS_LRCORNER; }
cchar_t* impl_WACS_LTEE() { return WACS_LTEE; }
cchar_t* impl_WACS_RTEE() { return WACS_RTEE; }
cchar_t* impl_WACS_BTEE() { return WACS_BTEE; }
cchar_t* impl_WACS_TTEE() { return WACS_TTEE; }
cchar_t* impl_WACS_HLINE() { return WACS_HLINE; }
cchar_t* impl_WACS_VLINE() { return WACS_VLINE; }
cchar_t* impl_WACS_PLUS() { return WACS_PLUS; }
cchar_t* impl_WACS_S1() { return WACS_S1; }
cchar_t* impl_WACS_S9() { return WACS_S9; }
cchar_t* impl_WACS_DIAMOND() { return WACS_DIAMOND; }
cchar_t* impl_WACS_CKBOARD() { return WACS_CKBOARD; }
cchar_t* impl_WACS_DEGREE() { return WACS_DEGREE; }
cchar_t* impl_WACS_PLMINUS() { return WACS_PLMINUS; }
cchar_t* impl_WACS_BULLET() { return WACS_BULLET; }
cchar_t* impl_WACS_LARROW() { return WACS_LARROW; }
cchar_t* impl_WACS_RARROW() { return WACS_RARROW; }
cchar_t* impl_WACS_DARROW() { return WACS_DARROW; }
cchar_t* impl_WACS_UARROW() { return WACS_UARROW; }
cchar_t* impl_WACS_BOARD() { return WACS_BOARD; }
cchar_t* impl_WACS_LANTERN() { return WACS_LANTERN; }
cchar_t* impl_WACS_BLOCK() { return WACS_BLOCK; }
cchar_t* impl_WACS_S3() { return WACS_S3; }
cchar_t* impl_WACS_S7() { return WACS_S7; }
cchar_t* impl_WACS_LEQUAL() { return WACS_LEQUAL; }
cchar_t* impl_WACS_GEQUAL() { return WACS_GEQUAL; }
cchar_t* impl_WACS_PI() { return WACS_PI; }
cchar_t* impl_WACS_NEQUAL() { return WACS_NEQUAL; }
cchar_t* impl_WACS_STERLING() { return WACS_STERLING; }
cchar_t* impl_WACS_BSSB() { return WACS_BSSB; }
cchar_t* impl_WACS_SSBB() { return WACS_SSBB; }
cchar_t* impl_WACS_BBSS() { return WACS_BBSS; }
cchar_t* impl_WACS_SBBS() { return WACS_SBBS; }
cchar_t* impl_WACS_SBSS() { return WACS_SBSS; }
cchar_t* impl_WACS_SSSB() { return WACS_SSSB; }
cchar_t* impl_WACS_SSBS() { return WACS_SSBS; }
cchar_t* impl_WACS_BSSS() { return WACS_BSSS; }
cchar_t* impl_WACS_BSBS() { return WACS_BSBS; }
cchar_t* impl_WACS_SBSB() { return WACS_SBSB; }
cchar_t* impl_WACS_SSSS() { return WACS_SSSS; }

