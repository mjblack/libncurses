require "../src/libncurses"

LibLocale.setlocale(LibLocale::LC_CTYPE, "")
LibNCurses.set_escdelay(0)

def init_ncurses
  LibNCurses.initscr
  LibNCurses.start_color
  LibNCurses.init_pair(1, LibNCurses::Color::White, LibNCurses::Color::Blue)
  LibNCurses.init_pair(2, LibNCurses::Color::Blue, LibNCurses::Color::White)
  LibNCurses.init_pair(3, LibNCurses::Color::Red, LibNCurses::Color::White)
  LibNCurses.curs_set(0)
  LibNCurses.noecho
  LibNCurses.keypad(LibNCurses.stdscr, true)
end

def draw_menubar(menubar : LibNCurses::WINDOW)
  LibNCurses.wbkgd(menubar, LibNCurses.color_pair(2))
  LibNCurses.waddstr(menubar, "Menu1".to_unsafe)
  LibNCurses.wattron(menubar, LibNCurses.color_pair(3))
  LibNCurses.waddstr(menubar, "(F1)".to_unsafe)
  LibNCurses.wattroff(menubar, LibNCurses.color_pair(3))
  LibNCurses.wmove(menubar, 0, 20)
  LibNCurses.waddstr(menubar, "Menu2".to_unsafe)
  LibNCurses.wattron(menubar, LibNCurses.color_pair(3))
  LibNCurses.waddstr(menubar, "(F2)")
  LibNCurses.wattroff(menubar, LibNCurses.color_pair(3))
end

def draw_menu(start_col : Int32) : LibNCurses::WINDOW*
  items = Pointer(LibNCurses::WINDOW).malloc(9)
  items[0] = LibNCurses.newwin(10, 19, 1, start_col)
  LibNCurses.wbkgd(items[0], LibNCurses.color_pair(2))
  LibNCurses.box(items[0], LibNCurses::ACS_VLINE, LibNCurses::ACS_HLINE)
  8.times do |i|
    item_id = i + 1
    y = i + 2
    items[item_id] = LibNCurses.subwin(items[0], 1, 17, y, start_col+1)
  end
  8.times do |i|
    LibNCurses.wprintw(items[i+1], "Item%d", i+1)
  end
  LibNCurses.wbkgd(items[1], LibNCurses.color_pair(1))
  LibNCurses.wrefresh(items[0])
  return items
end

def delete_menu(items : LibNCurses::WINDOW*, count : Int32)
  count.times do |i|
    LibNCurses.delwin(items[i])
  end
end

def scroll_menu(items : LibNCurses::WINDOW*, count : Int32, menu_start_col : Int32) : Int32
  selected = 0
  loop do
    key = LibNCurses.getch()
    if (key == LibNCurses::KEY_DOWN || key == LibNCurses::KEY_UP)
      LibNCurses.wbkgd(items[selected+1], LibNCurses.color_pair(2))
      LibNCurses.wnoutrefresh(items[selected+1])
      if key == LibNCurses::KEY_DOWN
        selected = (selected + 1) % count
      else
        selected = (selected + count - 1) % count
      end
      LibNCurses.wbkgd(items[selected+1], LibNCurses.color_pair(1))
      LibNCurses.wnoutrefresh(items[selected+1])
      LibNCurses.doupdate
    elsif (key == LibNCurses::KEY_LEFT || key == LibNCurses::KEY_RIGHT)
      delete_menu(items, count + 1)
      LibNCurses.touchwin(LibNCurses.stdscr)
      LibNCurses.refresh
      items = draw_menu(20 - menu_start_col)
      return scroll_menu(items, 8, 20 - menu_start_col)
    elsif key == LibNCurses::KEY_ESCAPE
      return -1
    elsif key == LibNCurses::KEY_ENTER
      return selected
    end
  end
end

init_ncurses
LibNCurses.bkgd(LibNCurses.color_pair(1))
menubar = LibNCurses.subwin(LibNCurses.stdscr, 1, 80, 0, 0)
messagebar = LibNCurses.subwin(LibNCurses.stdscr, 1, 79, 23, 1)
draw_menubar(menubar)
LibNCurses.move(2,1)
LibNCurses.printw("Press F1 or F2 to open the menus.".to_unsafe)
LibNCurses.move(3,1)
LibNCurses.printw("ESC quits.".to_unsafe)
LibNCurses.refresh
key = 0
while key != LibNCurses::KEY_ESCAPE
  key = LibNCurses.getch
  LibNCurses.werase(messagebar)
  LibNCurses.wrefresh(messagebar)
  if key == LibNCurses::KEY_F1
    menu_items = draw_menu(0)
    selected_item = scroll_menu(menu_items, 8, 0)
    delete_menu(menu_items, 9)
    if selected_item < 0
      LibNCurses.wprintw(messagebar, "You haven't selected any item.".to_unsafe)
    else
      LibNCurses.wprintw(messagebar, "You have selected menu item %d.".to_unsafe, selected_item+1)
    end
    LibNCurses.touchwin(LibNCurses.stdscr)
    LibNCurses.refresh
  elsif key == LibNCurses::KEY_F2
    menu_items = draw_menu(20)
    selected_item = scroll_menu(menu_items, 8, 20)
    delete_menu(menu_items, 9)
    if selected_item < 0
      LibNCurses.wprintw(messagebar, "You haven't selected any item.".to_unsafe)
    else
      LibNCurses.wprintw(messagebar, "You have selected menu item %d.".to_unsafe, selected_item+1)
    end
    LibNCurses.touchwin(LibNCurses.stdscr)
    LibNCurses.refresh
  end
end

LibNCurses.delwin(menubar)
LibNCurses.delwin(messagebar)
LibNCurses.endwin
