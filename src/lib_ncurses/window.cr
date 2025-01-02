@[Link("ncurses", ldflags: "`pkg-config ncurses --libs`")]
lib LibNCurses
  @[Flags]
  enum WindowFlags
    SubWin    = 0x01
    EndLine   = 0x02
    FullWin   = 0x04
    ScrollWin = 0x08
    IsPad     = 0x10
    HasMoved  = 0x20
    Wrapped   = 0x40
  end

  # Window functions
  fun newwin(Int32, Int32, Int32, Int32) : WINDOW
  fun delwin(WINDOW) : Int32
  fun derwin(WINDOW, Int32, Int32, Int32, Int32) : WINDOW
  fun putwin(WINDOW, Pointer(Void)) : Int32
  fun dupwin(WINDOW) : WINDOW
  fun getwin(Pointer(Void)) : WINDOW
  fun copywin(WINDOW, WINDOW, Int32, Int32, Int32, Int32, Int32, Int32, Int32) : Int32
  fun isendwin : Bool
  fun mvderwin(WINDOW, Int32, Int32) : Int32
  fun mvwin(WINDOW,Int32,Int32) : Int32
  fun subwin(WINDOW, Int32, Int32, Int32, Int32) : WINDOW
  fun is_wintouched(WINDOW) : Bool
  fun redrawwin(WINDOW) : Int32
  fun getcury(WINDOW) : Int32
  fun getcurx(WINDOW) : Int32
  fun getmaxy(WINDOW) : Int32
  fun getmaxx(WINDOW) : Int32
  fun intrflush(WINDOW, Bool) : Int32

  # Window state functions
  fun is_linetouched(WINDOW, Int32) : Bool
  fun wtouchln(WINDOW, Int32, Int32, Int32) : Int32
  fun wrefresh(WINDOW) : Int32
  fun touchline(WINDOW, Int32, Int32) : Int32
  fun touchwin(WINDOW) : Int32
  fun untouchwin(WINDOW) : Int32
  fun wcursyncup(WINDOW)
  fun wsyncdown(WINDOW)
  fun wsyncup(WINDOW)
  fun wstandout(WINDOW) : Int32
  fun wstandend(WINDOW) : Int32
  fun wnoutrefresh(WINDOW) : Int32
  fun doupdate : Int32

  # Window scroll functions
  fun scroll(WINDOW) : Int32
  fun wscrl(WINDOW,Int32) : Int32

  # Window cursor functions
  fun wmove(WINDOW,Int32,Int32) : Int32

  # Window input functions
  fun keypad(WINDOW, Bool) : Int32
  fun nodelay(WINDOW, Bool) : Int32
  fun notimeout(WINDOW,Bool) : Int32
  fun wtimeout(WINDOW, Int32)
  fun mvwgetch(WINDOW, Int32, Int32) : Int32
  fun mvwgetnstr(WINDOW, Int32, Int32, UInt8*, Int32) : Int32
  fun mvwgetstr(WINDOW, Int32, Int32, UInt8*) : Int32
  fun mvwinnstr(WINDOW, Int32, Int32, UInt8*, Int32) : Int32
  fun mvwinsnstr(WINDOW, Int32, Int32, UInt8*, Int32) : Int32
  fun mvwinsstr(WINDOW, Int32, Int32, UInt8*) : Int32
  fun mvwinstr(WINDOW, Int32, Int32, UInt8*) : Int32
  fun wscanw(WINDOW, UInt8*,...) : Int32
  fun mvwscanw(WINDOW,Int32,Int32, UInt8*,...) : Int32
  fun winnstr(WINDOW, UInt8*, Int32) : Int32
  fun winsnstr(WINDOW, UInt8*,Int32) : Int32
  fun winsstr(WINDOW, UInt8*) : Int32
  fun winstr(WINDOW, UInt8*) : Int32
  fun wgetch(WINDOW) : Int32
  fun wgetnstr(WINDOW,UInt8*,Int32) : Int32
  fun wgetstr(WINDOW, UInt8*) : Int32

  # Window output functions
  fun waddnstr(WINDOW,UInt8*,Int32) : Int32
  fun waddstr(WINDOW,UInt8*) : Int32
  fun mvwaddnstr(WINDOW, Int32, Int32, UInt8*, Int32) : Int32
  fun mvwaddstr(WINDOW, Int32, Int32, UInt8*) : Int32
  fun mvwaddch(WINDOW, Int32, Int32, CHType) : Int32
  fun waddch(WINDOW,  CHType) : Int32
  fun box(WINDOW, CHType, CHType) : Int32
  fun wborder(WINDOW, CHType, CHType, CHType, CHType, CHType, CHType, CHType, CHType) : Int32
  fun wvline(WINDOW, CHType, Int32) : Int32
  fun whline(WINDOW, CHType, Int32) : Int32
  fun wprintw(WINDOW, UInt8*, ...) : Int32
  fun mvwprintw(WINDOW,Int32,Int32, UInt8*,...) : Int32
  fun mvwinsch(WINDOW, Int32, Int32, CHType) : Int32
  fun winch(WINDOW) : CHType
  fun mvwinch(WINDOW, Int32, Int32) : CHType
  fun winsch(WINDOW, CHType) : Int32
  fun werase(WINDOW) : Int32
  fun wclear(WINDOW) : Int32
  fun wclrtobot(WINDOW) : Int32
  fun wclrtoeol(WINDOW) : Int32
  fun wredrawln(WINDOW, Int32, Int32) : Int32
  fun mvwdelch(WINDOW, Int32, Int32) : Int32

  # Window output options functions
  fun leaveok(WINDOW, Bool) : Int32
  fun idcok(WINDOW, Bool) : Void
  fun idlok(WINDOW, Bool) : Int32
  fun scrollok(WINDOW, Bool) : Int32
  fun wsetscrreg(WINDOW, Int32, Int32) : Int32
  fun immedok(WINDOW, Bool) : Void
  fun clearok(WINDOW, Bool) : Int32

  # Window line functions
  fun mvwhline(WINDOW, Int32, Int32, CHType, Int32) : Int32
  fun mvwvline(WINDOW, Int32, Int32, CHType, Int32) : Int32
  fun winsdelln(WINDOW,Int32) : Int32
  fun winsertln(WINDOW) : Int32

  # Window background functions
  fun wbkgd(WINDOW, CHType) : Int32
  fun wbkgdset(WINDOW, CHType)
  fun getbkgd(WINDOW) : CHType

  # Window attributes functions
  fun wcolor_set(WINDOW, Int16, Pointer(Void)) : Int32
  fun wattr_get(WINDOW, Pointer(AttrT), Pointer(Int16), Pointer(Void)) : Int32
  fun wattr_on(WINDOW, AttrT, Pointer(Void)) : Int32
  fun wattr_off(WINDOW, AttrT, Pointer(Void)) : Int32
  fun wattr_set(WINDOW, AttrT, Int16, Pointer(Void)) : Int32

  fun wattron(WINDOW, Int32) : Int32 # Legacy
  fun wattroff(WINDOW, Int32) : Int32 # Legacy
  fun wattrset(WINDOW, Int32) : Int32 # Legacy

  {% if flag?(:NCURSES_WIDECHAR) %}
  fun box_set(WINDOW, CCharT*, CCharT*) : Int32
  fun mvwadd_wch(WINDOW, Int32, Int32, CCharT*) : Int32
  fun mvwadd_wchnstr(WINDOW, Int32, Int32, CCharT*, int) : Int32
  fun mvwadd_wchstr(WINDOW, Int32, Int32, CCharT*) : Int32
  fun mvwaddnwstr(WINDOW, Int32, Int32, WCharT*, int) : Int32
  fun mvwaddwstr(WINDOW, Int32, Int32, WCharT*) : Int32
  fun mvwget_wch(WINDOW, Int32, Int32, WIntT*) : Int32
  fun mvwget_wstr(WINDOW, Int32, Int32, WIntT*) : Int32
  fun mvwgetn_wstr(WINDOW, Int32, Int32, WIntT*, int) : Int32
  fun mvwhline_set(WINDOW, Int32, Int32, CCharT*, int) : Int32
  fun mvwin_wch(WINDOW, Int32, Int32, CCharT*) : Int32
  fun mvwin_wchnstr(WINDOW, Int32, Int32, CCharT*, Int32) : Int32
  fun mvwin_wchstr(WINDOW, Int32, Int32, CCharT*) : Int32
  fun mvwinnwstr(WINDOW, Int32, Int32, WCharT, int) : Int32
  fun mvwins_nwstr(WINDOW, Int32, Int32, WCharT*, Int32) : Int32
  fun mvwins_wch(WINDOW, Int32, Int32, CCharT*) : Int32
  fun mvwins_wstr(WINDOW, Int32, Int32, WCharT*) : Int32
  fun mvwinwstr(WINDOW, Int32, Int32, WCharT) : Int32
  fun mvwvline_set(WINDOW, Int32, Int32, CCharT*, Int32) : Int32
  fun pecho_wchar(WINDOW, CCharT*) : Int32
  fun wadd_wch(WINDOW, CCharT*) : Int32
  fun wadd_wchnstr(WINDOW, CCharT*, Int32) : Int32
  fun wadd_wchstr(WINDOW, CCharT*) : Int32
  fun waddnwstr(WINDOW, WCharT*, Int32) : Int32
  fun waddwstr(WINDOW, WCharT*) : Int32
  fun wbkgrnd(WINDOW, CCharT*) : Int32
  fun wbkgrndset(WINDOW, CCharT*)
  fun wborder_set(WINDOW, CCharT*, CCharT*, CCharT*, CCharT*, CCharT*, CCharT*, CCharT*, CCharT*) : Int32
  fun wecho_wchar(WINDOW, CCharT*) : Int32
  fun wget_wch(WINDOW, WIntT*) : Int32
  fun wget_wstr(WINDOW, WIntT*) : Int32
  fun wgetbkgrnd(WINDOW, CCharT*) : Int32
  fun wgetn_wstr(WINDOW, WIntT*, int) : Int32
  fun whline_set(WINDOW, CCharT*, int) : Int32
  fun win_wch(WINDOW, CCharT*) : Int32
  fun win_wchnstr(WINDOW, CCharT*, int) : Int32
  fun win_wchstr(WINDOW, CCharT*) : Int32
  fun winnwstr(WINDOW, WCharT, int) : Int32
  fun wins_nwstr(WINDOW, WCharT*, int) : Int32
  fun wins_wch(WINDOW, CCharT*) : Int32
  fun wins_wstr(WINDOW, WCharT*) : Int32
  fun winwstr(WINDOW, WCharT) : Int32
  fun wvline_set(WINDOW, CCharT*, int) : Int32
  {% end %}
end

