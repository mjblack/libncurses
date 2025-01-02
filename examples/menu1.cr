require "../src/libncurses"

choices = [
    ["Choice 1", "Choice 1"],
    ["Choice 2", "Choice 2"],
    ["Choice 3", "Choice 3"],
    ["Choice 4", "Choice 4"],
    ["Exit", "Exit"],
]

window = LibNCurses.initscr
LibNCurses.cbreak
LibNCurses.noecho
LibNCurses.keypad(window, true)

n_choices = choices.size
my_items = Pointer(LibNCurses::ITEM).malloc(sizeof(LibNCurses::ITEM) * (n_choices + 1))

n_choices.times do |i|
  name, desc = choices[i]
  my_items[i] = LibNCurses.new_item(name.to_unsafe, desc.to_unsafe)
end

my_items[n_choices] = Pointer(LibNCurses::ItemT).null

my_menu = LibNCurses.new_menu(my_items)

LibNCurses.mvprintw(LibNCurses.lines - 2, 0, "F1 to Exit".to_unsafe)
LibNCurses.post_menu(my_menu)
LibNCurses.refresh

while (c = LibNCurses.getch) != LibNCurses::KEY_F1
  case c
  when LibNCurses::KEY_DOWN
    LibNCurses.menu_driver(my_menu, LibNCurses::REQ_DOWN_ITEM)
  when LibNCurses::KEY_UP
    LibNCurses.menu_driver(my_menu, LibNCurses::REQ_UP_ITEM)
  end
end

n_choices.times do |i|
  LibNCurses.free_item(my_items[i])
end

LibNCurses.free_menu(my_menu)
LibNCurses.endwin
