require "../src/libncurses"

win = LibNCurses.initscr
LibNCurses.cbreak
LibNCurses.noecho
LibNCurses.keypad(win, true)
maxy = LibNCurses.getmaxy(win)
maxx = LibNCurses.getmaxx(win)
str1 = "Hello World!"
str2 = "Press F1 to quit..."
start_posx_1 = (maxx / 2) - str1.size
LibNCurses.mvwaddstr(win, maxy / 2, start_posx_1, str1.to_unsafe)
LibNCurses.mvwaddstr(win, (maxy / 2)+1, start_posx_1, str2.to_unsafe)

while (c = LibNCurses.getch) != LibNCurses::KEY_F1
  sleep 1.seconds
end

LibNCurses.endwin
