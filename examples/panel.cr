require "../src/libncurses"

my_wins = [] of LibNCurses::WINDOW
my_panels = [] of LibNCurses::PANEL
lines = 10
cols = 40
y = 2
x = 4
i = 0

LibNCurses.initscr
LibNCurses.cbreak
LibNCurses.noecho

win1 = LibNCurses.newwin(lines, cols, y, x)
win2 = LibNCurses.newwin(lines, cols, y + 1, x + 5)
win3 = LibNCurses.newwin(lines, cols, y + 2, x + 10)
my_wins << win1
my_wins << win2
my_wins << win3

my_wins.each { |x| LibNCurses.box(x, 0, 0) }
my_wins.each { |x| my_panels << LibNCurses.new_panel(x) }

LibNCurses.update_panels
LibNCurses.doupdate
LibNCurses.getch
LibNCurses.endwin
