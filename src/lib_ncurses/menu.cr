@[Link("menu")]#, ldflags: "`pkg-config menu --libs`")]
lib LibNCurses
  alias MenuOptions = Int32
  alias ItemOptions = Int32
  alias MenuHook = Void*

  REQ_LEFT_ITEM     = (LibNCurses::KEY_MAX + 1)
  REQ_RIGHT_ITEM    = (LibNCurses::KEY_MAX + 2)
  REQ_UP_ITEM       = (LibNCurses::KEY_MAX + 3)
  REQ_DOWN_ITEM     = (LibNCurses::KEY_MAX + 4)
  REQ_SCR_ULINE     = (LibNCurses::KEY_MAX + 5)
  REQ_SCR_DLINE     = (LibNCurses::KEY_MAX + 6)
  REQ_SCR_DPAGE     = (LibNCurses::KEY_MAX + 7)
  REQ_SCR_UPAGE     = (LibNCurses::KEY_MAX + 8)
  REQ_FIRST_ITEM    = (LibNCurses::KEY_MAX + 9)
  REQ_LAST_ITEM     = (LibNCurses::KEY_MAX + 10)
  REQ_NEXT_ITEM     = (LibNCurses::KEY_MAX + 11)
  REQ_PREV_ITEM     = (LibNCurses::KEY_MAX + 12)
  REQ_TOGGLE_ITEM   = (LibNCurses::KEY_MAX + 13)
  REQ_CLEAR_PATTERN = (LibNCurses::KEY_MAX + 14)
  REQ_BACK_PATTERN  = (LibNCurses::KEY_MAX + 15)
  REQ_NEXT_MATCH    = (LibNCurses::KEY_MAX + 16)
  REQ_PREV_MATCH    = (LibNCurses::KEY_MAX + 17)

  MIN_MENU_COMMAND  = (LibNCurses::KEY_MAX + 1)
  MAX_MENU_COMMAND  = (LibNCurses::KEY_MAX + 17)



  @[Flags]
  enum MenuOption : Int32
    OneValue     = 0x01
    ShowDesc     = 0x02
    RowMajor     = 0x04
    IgnoreCase   = 0x08
    ShowMatch    = 0x10
    NonCyclic    = 0x20
    MouseMenu    = 0x40
  end

  @[Flags]
  enum ItemOption : Int32
    Selectable    = 0x01
  end

  type ItemT = Void
  alias ITEM = ItemT*
  type MenuT = Void
  alias MENU = MenuT*


  # Menu functions
  fun new_menu(ITEM*) : MENU
  fun menu_items(MENU) : Pointer(ITEM)
  fun menu_opts(MENU) : Pointer(MenuOptions)
  fun menu_init(MENU) : MenuHook
  fun menu_term(MENU) : MenuHook
  fun menu_sub(MENU) : WINDOW
  fun menu_win(MENU) : WINDOW
  fun menu_mark(MENU) : Pointer(Char)
  fun menu_request_name(Int32) : Pointer(Char)
  fun menu_pattern(MENU) : Pointer(Char)
  fun menu_userptr(MENU) : Pointer(Void)
  fun menu_back(MENU) : CHType
  fun menu_fore(MENU) : CHType
  fun menu_grey(MENU) : CHType
  fun free_menu(MENU) : Int32
  fun menu_driver(MENU, Int32) : Int32
  fun menu_opts_off(MENU, MenuOptions) : Int32
  fun menu_opts_on(MENU, MenuOptions) : Int32
  fun menu_pad(MENU) : Int32
  fun pos_menu_cursor(MENU) : Int32
  fun post_menu(MENU) : Int32
  fun scale_menu(MENU, Pointer(Int32), Pointer(Int32)) : Int32
  fun set_menu_back(MENU, CHType) : Int32
  fun set_menu_fore(MENU, CHType) : Int32
  fun set_menu_format(MENU, Int32, Int32) : Int32
  fun set_menu_grey(MENU, CHType) : Int32
  fun set_menu_init(MENU, MenuHook) : Int32
  fun set_menu_items(MENU, ITEM*) : Int32
  fun set_menu_mark(MENU, Pointer(UInt8)) : Int32
  fun set_menu_opts(MENU, MenuOptions) : Int32
  fun set_menu_pad(MENU, Int32) : Int32
  fun set_menu_pattern(MENU, Pointer(UInt8)) : Int32
  fun set_menu_sub(MENU, WINDOW) : Int32
  fun set_menu_term(MENU, MenuHook) : Int32
  fun set_menu_userptr(MENU, Pointer(Void)) : Int32
  fun set_menu_win(MENU, WINDOW) : Int32
  fun set_top_row(MENU, Int32) : Int32
  fun top_row(MENU) : Int32
  fun unpost_menu(MENU) : Int32
  fun menu_request_by_name(Pointer(UInt8)) : Int32
  fun set_menu_spacing(MENU, Int32, Int32, Int32) : Int32
  fun menu_spacing(MENU, Pointer(Int32), Pointer(Int32), Pointer(Int32)) : Int32
  fun menu_format(MENU, Pointer(Int32), Pointer(Int32)) : Void

  # Item functions
  fun current_items(MENU) : ITEM
  fun new_item(Pointer(UInt8), Pointer(UInt8)) : ITEM
  fun item_opts(ITEM) : Pointer(ItemOptions)
  fun item_init(MENU) : MenuHook
  fun item_term(MENU) : MenuHook
  fun item_description(ITEM) : Pointer(Char)
  fun item_name(ITEM) : Pointer(Char)
  fun item_userptr(ITEM) : Pointer(Void)
  fun free_item(ITEM) : Int32
  fun item_count(MENU) : Int32
  fun item_index(ITEM) : Int32
  fun item_opts_off(ITEM, ItemOptions) : Int32
  fun item_opts_on(ITEM, ItemOptions) : Int32
  fun set_current_item(MENU, ITEM) : Int32
  fun set_item_init(MENU, MenuHook) : Int32
  fun set_item_opts(ITEM, ItemOptions) : Int32
  fun set_item_term(MENU, MenuHook) : Int32
  fun set_item_userptr(ITEM, Pointer(Void)) : Int32
  fun set_item_value(ITEM, Bool) : Int32
  fun item_value(ITEM) : Bool
  fun item_visible(ITEM) : Bool
end
