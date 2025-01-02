#include <stdio.h>
#include <ncurses.h>
#include <unistd.h>
#include <string.h>


int main() {

  int maxx, maxy, start_posx, c;
  char *str1 = "Hello World!";
  char *str2 = "Press F1 to quit...";
  WINDOW* win = initscr();
  cbreak();
  noecho();
  keypad(win, true);
  maxy = getmaxy(win);
  maxx = getmaxx(win);

  start_posx = (int)((maxx / 2) - strlen(str1));
  mvwaddstr(win, (int)(maxy / 2), start_posx, str1);
  mvwaddstr(win, (int)((maxy/2) + 1), start_posx, str2);

  while((c = getch() != KEY_F(1))) {
    sleep(1);
  }
  echo();
  nocbreak();
  endwin();
  return 0;
}
