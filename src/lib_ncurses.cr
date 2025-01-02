lib LibLocale

  LC_CTYPE = 0
  fun setlocale(cat : Int32, locale : LibC::Char*) : LibC::Char*
end

{% begin %}
{%
  cflags = ""
  library = "ncurses"
  if flag?(:NCURSES_WIDECHAR)
    cflags = "-DNCURSES_WIDECHAR"
    library = "ncursesw"
  end
  unless file_exists?("#{__DIR__}/lib_ncurses/wrapper.o")
    `clang #{__DIR__}/lib_ncurses/wrapper.c -c -o #{__DIR__}/lib_ncurses/wrapper.o #{cflags}`
  end
%}
@[Link(ldflags: "'#{__DIR__}/lib_ncurses/wrapper.o'")]
@[Link({{library}})]#, ldflags: "`pkg-config ncurses --libs`")]
{% end %}
lib LibNCurses

  VERSION = {{`shards version #{__DIR__}`.chomp.stringify}}

  # 32 bit vs 64 bit stuff first
  {% if flag?(:bits32) %}
  alias IntPtrT = Int32
  alias UIntPtrT = UInt32
  {% else %}
  alias IntPtrT = Int64
  alias UIntPtrT = UInt64
  {% end %}

  alias WCharT = Int32

  {% if flag?(:NCURSES_WIDECHAR) %}
  alias CharT = WCharT
  {% else %}
  alias CharT = UInt8
  {% end %}

  # Bool conversion
  TRUE = true.to_unsafe
  FALSE = false.to_unsafe

  # Error codes
  enum Error
    OK              = 0
    SYSTEM_ERROR    = -1
    BAD_ARGUMENT    = -2
    POSTED          = -3
    CONNECTED       = -4
    BAD_STATE       = -5
    NO_ROOM         = -6
    NOT_POSTED      = -7
    UNKNOWN_COMMAND = -8
    NO_MATCH        = -9
    NOT_SELECTABLE  = -10
    NOT_CONNECTED   = -11
    REQUEST_DENIED  = -12
    INVALID_FIELD   = -13
    CURRENT         = -14
  end

  # Global variables and aliases
  $acs_map : CHType*
  $lines = LINES : Int32
  $stdscr : WINDOW
  $curscr : WINDOW
  $newscr : WINDOW
  $ttytype : UInt8*
  $colors = COLORS : Int32
  $color_pairs = COLOR_PAIRS : Int32
  $cols = COLS : Int32
  $escdelay = ESCDELAY : Int32
  $tabsize = TABSIZE : Int32

  CCHARW_MAX = 5
  NCURSES_EXT_COLORS = 20240427

  type SCREEN = Void*
  type WindowT = Void
  alias WINDOW = WindowT*
  alias WIntType = UInt32
  alias MMaskT = UInt32
  alias AttrT = CHType
  alias CHType = UInt32

  alias NCURSES_OUTC = Proc(Int32, Int32)

  enum Color : Int32
    Black   = 0
    Red     = 1
    Green   = 2
    Yellow  = 3
    Blue    = 4
    Magenta = 5
    Cyan    = 6
    White   = 7
  end

  COLOR_BLACK   = 0_i16
  COLOR_RED     = 1_i16
  COLOR_GREEN   = 2_i16
  COLOR_YELLOW  = 3_i16
  COLOR_BLUE    = 4_i16
  COLOR_MAGENTA = 5_i16
  COLOR_CYAN    = 6_i16
  COLOR_WHITE   = 7_i16

  struct Version
    major : Int32
    minor : Int32
    patch : Int32
  end

  struct CCharT
    attr : AttrT
    chars : WCharT[CCHARW_MAX]
    ext_colors : Int32
  end

  ACS_ULCORNER = acs_ulcorner
  ACS_LLCORNER = acs_llcorner
  ACS_URCORNER = acs_urcorner
  ACS_LRCORNER = acs_lrcorner
  ACS_LTEE = acs_ltee
  ACS_RTEE = acs_rtee
  ACS_BTEE = acs_btee
  ACS_TTEE = acs_ttee
  ACS_HLINE = acs_hline
  ACS_VLINE = acs_vline
  ACS_PLUS = acs_plus
  ACS_S1 = acs_s1
  ACS_S9 = acs_s9
  ACS_DIAMOND = acs_diamond
  ACS_CKBOARD = acs_ckboard
  ACS_DEGREE = acs_degree
  ACS_PLMINUS = acs_plminus
  ACS_BULLET = acs_bullet
  ACS_LARROW = acs_larrow
  ACS_RARROW = acs_rarrow
  ACS_DARROW = acs_darrow
  ACS_UARROW = acs_uarrow
  ACS_BOARD = acs_board
  ACS_LANTERN = acs_lantern
  ACS_BLOCK = acs_block
  ACS_S3 = acs_s3
  ACS_S7 = acs_s7
  ACS_LEQUAL = acs_lequal
  ACS_GEQUAL = acs_gequal
  ACS_PI = acs_pi
  ACS_NEQUAL = acs_nequal
  ACS_STERLING = acs_sterling
  ACS_BSSB = acs_bssb
  ACS_SSBB = acs_ssbb
  ACS_BBSS = acs_bbss
  ACS_SBBS = acs_sbbs
  ACS_SBSS = acs_sbss
  ACS_SSSB = acs_sssb
  ACS_SSBS = acs_ssbs
  ACS_BSSS = acs_bsss
  ACS_BSBS = acs_bsbs
  ACS_SBSB = acs_sbsb
  ACS_SSSS = acs_ssss


  Err = -1
  Ok  = 0

  NoChange  = -1
  NewIndex  = -1

  # (De)constructors
  fun initscr : WINDOW
  fun endwin : Int32

  fun cbreak : Int32
  fun nocbreak : Int32
  fun echo : Int32
  fun noecho : Int32
  fun raw : Int32
  fun noraw : Int32
  fun nl : Int32
  fun nonl : Int32
  fun set_escdelay(Int32) : Int32
  fun get_escdelay : Int32

  # Input Functions
  fun getch : Int32
  fun getnstr(UInt8*, Int32) : Int32
  fun getstr(UInt8*) : Int32
  fun mvaddch(Int32, Int32, CHType) : Int32
  fun mvaddchnstr(Int32, Int32, Pointer(CHType), Int32) : Int32
  fun mvaddchstr(Int32, Int32, Pointer(CHType)) : Int32
  fun mvaddnstr(Int32, Int32, UInt8*, Int32) : Int32
  fun mvaddstr(Int32, Int32, UInt8*) : Int32
  fun mvgetch(Int32, Int32) : Int32
  fun mvgetnstr(Int32, Int32, UInt8*, Int32) : Int32
  fun mvgetstr(Int32, Int32, UInt8*) : Int32
  fun mvinchnstr(Int32, Int32, Pointer(CHType), Int32) : Int32
  fun mvinchstr(Int32, Int32, Pointer(CHType)) : Int32
  fun inchnstr(Pointer(CHType), Int32) : Int32
  fun inchstr(Pointer(CHType)) : Int32


  # Attribute functions
  fun attroff(Int32) : Int32
  fun attron(Int32) : Int32
  fun attrset(Int32) : Int32
  fun attr_get(AttrT*, Int16*, Void*) : Int32
  fun attr_off(AttrT, Void*) : Int32
  fun attr_on(AttrT, Void*) : Int32
  fun attr_set(AttrT, Int16, Void*) : Int32

  # Color functions
  fun init_color(Int16, Int16, Int16, Int16) : Int32
  fun init_pair(Int16, Int16, Int16) : Int32
  fun can_change_color : Bool
  fun has_colors : Bool
  fun start_color : Int32
  fun color_content(Int16, Int16*, Int16*, Int16*) : Int32
  fun color_set(Int16, Void*) : Int32
  # fun color_pair = COLOR_PAIR(Int32) : Int32
  fun color_pair(Int32) : Int32
  fun pair_content(Int16,Int16*,Int16*) : Int32
  fun pair_number = PAIR_NUMBER(Int32) : Int32

  # Char/String rendering attributes functions
  fun mvchgat(Int32, Int32, Int32, AttrT, Int16, Pointer(Void)) : Int32
  fun chgat(Int32, AttrT, Int16, Void*) : Int32
  fun mvwchgat(WINDOW, Int32, Int32, Int32, AttrT, Int16, Pointer(Void)) : Int32
  fun wchgat(WINDOW, Int32, AttrT, Int16, Pointer(Void)) : Int32

  # Output functions
  fun addch (CHType) : Int32
  fun addchnstr (CHType*, Int32) : Int32
  fun addchstr (CHType*) : Int32
  fun addnstr (UInt8*, Int32) : Int32
  fun addstr (UInt8*) : Int32
  fun beep : Int32
  fun bkgd (CHType) : Int32
  fun bkgdset(CHType) : Void
  fun border(CHType, CHType, CHType, CHType, CHType, CHType, CHType, CHType) : Int32
  fun echochar(CHType) : Int32
  fun delay_output(Int32) : Int32
  fun delch : Int32
  fun delscreen(SCREEN*) : Void
  fun deleteln : Int32
  fun erase : Int32
  fun erasechar : Char
  fun mvinsch(Int32, Int32, CHType) : Int32
  fun insch(CHType) : Int32
  fun mvinch(Int32, Int32) : CHType
  fun inch : CHType
  fun printw(UInt8*, ...) : Int32

  # Line functions
  fun hline(CHType, Int32) : Int32
  fun vline(CHType, Int32) : Int32
  fun mvvline(Int32, Int32, CHType, Int32) : Int32
  fun mvhline(Int32, Int32, CHType, Int32) : Int32

  # Screen functions
  fun refresh : Int32
  fun clear : Int32

  # Cursor functions
  fun curs_set(Int32) : Int32
  fun mvcur(Int32, Int32, Int32, Int32) : Int32

  # Misc functions
  fun napms(Int32) : Int32  # Sleep for `n` ms
  fun clrtobot : Int32
  fun clrtoeol : Int32
  fun def_prog_mode : Int32
  fun def_shell_mode : Int32
  fun doupdate : Int32
  fun filter : Void
  fun flash : Int32
  fun flushinp : Int32
  fun halfdelay(Int32) : Int32
  fun has_ic : Bool
  fun has_il : Bool
  fun innstr(UInt8*, Int32) : Int32
  fun insdelln(Int32) : Int32
  fun insertln : Int32
  fun insnstr(UInt8*, Int32) : Int32
  fun insstr(UInt8*) : Int32
  fun instr(UInt8*) : Int32
  fun keyname(Int32) : UInt8*
  fun killchar : Char
  fun longname : UInt8*
  fun meta(WINDOW, Bool) : Int32
  fun move(Int32, Int32) : Int32
  fun mvdelch(Int32, Int32) : Int32
  fun mvinnstr(Int32, Int32, UInt8*, Int32) : Int32
  fun mvinsnstr(Int32, Int32, UInt8*, Int32) : Int32
  fun mvinsstr(Int32, Int32, UInt8*) : Int32
  fun mvinstr(Int32, Int32, UInt8*) : Int32
  fun mvprintw(Int32,Int32, UInt8*,...) : Int32
  fun mvscanw(Int32,Int32, UInt8*,...) : Int32
  fun newterm(UInt8*, Pointer(Void), Pointer(Void)) : Pointer(SCREEN)
  fun noqiflush
  fun overlay(WINDOW,WINDOW) : Int32
  fun overwrite(WINDOW,WINDOW) : Int32

  fun pechochar(WINDOW, CHType) : Int32
  fun pnoutrefresh(WINDOW,Int32,Int32,Int32,Int32,Int32,Int32) : Int32
  fun prefresh(WINDOW,Int32,Int32,Int32,Int32,Int32,Int32) : Int32
  fun qiflush
  fun resetty : Int32
  fun reset_prog_mode : Int32
  fun reset_shell_mode : Int32
  fun ripoffline(Int32, Pointer(Void), Int32) : Int32
  fun savetty : Int32
  fun scanw(UInt8*,...) : Int32
  fun scr_dump(UInt8*) : Int32
  fun scr_init(UInt8*) : Int32
  fun scrl(Int32) : Int32
  fun scr_restore(UInt8*) : Int32
  fun scr_set(UInt8*) : Int32
  fun setscrreg(Int32,Int32) : Int32
  fun set_term(SCREEN) : SCREEN
  fun slk_attroff(CHType) : Int32
  fun slk_attr_off(AttrT, Pointer(Void)) : Int32
  fun slk_attron(CHType) : Int32
  fun slk_attr_on(AttrT,Pointer(Void)) : Int32
  fun slk_attrset(CHType) : Int32
  fun slk_attr : AttrT
  fun slk_attr_set(AttrT,Int16,Pointer(Void)) : Int32
  fun slk_clear : Int32
  fun slk_color(Int16) : Int32
  fun slk_init(Int32) : Int32
  fun slk_label(Int32) : UInt8*
  fun slk_noutrefresh : Int32
  fun slk_refresh : Int32
  fun slk_restore : Int32
  fun slk_set(Int32,UInt8*,Int32) : Int32
  fun slk_touch : Int32
  fun standout : Int32
  fun standend : Int32

  fun termattrs : CHType
  fun termname : UInt8*
  fun timeout : Int32
  fun typeahead(Int32) : Int32
  fun ungetch(Int32) : Int32
  fun use_env(Bool)
  fun use_tioctl(Bool)
  fun vidattr(CHType) : Int32
  fun vidputs(CHType, NCURSES_OUTC) : Int32


  # Pad functions
  fun newpad(Int32, Int32) : WINDOW

  # Wrappers for ACS_ constants
  fun acs_ulcorner = impl_ACS_ULCORNER : Int32
  fun acs_llcorner = impl_ACS_LLCORNER : Int32
  fun acs_urcorner = impl_ACS_URCORNER : Int32
  fun acs_lrcorner = impl_ACS_LRCORNER : Int32
  fun acs_ltee = impl_ACS_LTEE : Int32
  fun acs_rtee = impl_ACS_RTEE : Int32
  fun acs_btee = impl_ACS_BTEE : Int32
  fun acs_ttee = impl_ACS_TTEE : Int32
  fun acs_hline = impl_ACS_HLINE : Int32
  fun acs_vline = impl_ACS_VLINE : Int32
  fun acs_plus = impl_ACS_PLUS : Int32
  fun acs_s1 = impl_ACS_S1 : Int32
  fun acs_s9 = impl_ACS_S9 : Int32
  fun acs_diamond = impl_ACS_DIAMOND : Int32
  fun acs_ckboard = impl_ACS_CKBOARD : Int32
  fun acs_degree = impl_ACS_DEGREE : Int32
  fun acs_plminus = impl_ACS_PLMINUS : Int32
  fun acs_bullet = impl_ACS_BULLET : Int32
  fun acs_larrow = impl_ACS_LARROW : Int32
  fun acs_rarrow = impl_ACS_RARROW : Int32
  fun acs_darrow = impl_ACS_DARROW : Int32
  fun acs_uarrow = impl_ACS_UARROW : Int32
  fun acs_board = impl_ACS_BOARD : Int32
  fun acs_lantern = impl_ACS_LANTERN : Int32
  fun acs_block = impl_ACS_BLOCK : Int32
  fun acs_s3 = impl_ACS_S3 : Int32
  fun acs_s7 = impl_ACS_S7 : Int32
  fun acs_lequal = impl_ACS_LEQUAL : Int32
  fun acs_gequal = impl_ACS_GEQUAL : Int32
  fun acs_pi = impl_ACS_PI : Int32
  fun acs_nequal = impl_ACS_NEQUAL : Int32
  fun acs_sterling = impl_ACS_STERLING : Int32
  fun acs_bssb = impl_ACS_BSSB : Int32
  fun acs_ssbb = impl_ACS_SSBB : Int32
  fun acs_bbss = impl_ACS_BBSS : Int32
  fun acs_sbbs = impl_ACS_SBBS : Int32
  fun acs_sbss = impl_ACS_SBSS : Int32
  fun acs_sssb = impl_ACS_SSSB : Int32
  fun acs_ssbs = impl_ACS_SSBS : Int32
  fun acs_bsss = impl_ACS_BSSS : Int32
  fun acs_bsbs = impl_ACS_BSBS : Int32
  fun acs_sbsb = impl_ACS_SBSB : Int32
  fun acs_ssss = impl_ACS_SSSS : Int32

  {% if flag?(:NCURSES_WIDECHAR) %}

  # Input functions
  fun get_wch(WIntT*) : Int32
  fun get_wstr(WIntT*) : Int32
  fun getn_wstr(WIntT*, Int32) : Int32
  fun getcchar(CCharT*, WCharT*, AttrT*, NCURSES_PAIRS_T*, Void*) : Int32
  fun in_wch(CCharT*) : Int32
  fun in_wchnstr(CCharT*, Int32) : Int32
  fun in_wchstr(CCharT*) : Int32
  fun innwstr(WCharT, Int32) : Int32
  fun ins_nwstr(WCharT*, Int32) : Int32
  fun ins_wch(CCharT*) : Int32
  fun ins_wstr(WCharT*) : Int32
  fun inwstr(WCharT) : Int32
  fun mvget_wch(Int32, Int32, WIntT*) : Int32
  fun mvget_wstr(Int32, Int32, WIntT*) : Int32
  fun mvgetn_wstr(Int32, Int32, WIntT*, Int32) : Int32
  fun mvin_wch(Int32, Int32, CCharT*) : Int32
  fun mvin_wchnstr(Int32, Int32, CCharT*, Int32) : Int32
  fun mvin_wchstr(Int32, Int32, CCharT*) : Int32
  fun mvinnwstr(Int32, Int32, WCharT, Int32) : Int32
  fun mvins_nwstr(Int32, Int32, WCharT*, Int32) : Int32
  fun mvins_wch(Int32, Int32, CCharT*) : Int32
  fun mvins_wstr(Int32, Int32, WCharT*) : Int32
  fun mvinwstr(Int32, Int32, WCharT) : Int32

  # Output functions
  fun add_wch(CCharT*) : Int32
  fun add_wchnstr(CCharT*, Int32) : Int32
  fun add_wchstr(CCharT*) : Int32
  fun addnwstr(WCharT*, Int32) : Int32
  fun addwstr(WCharT*) : Int32
  fun echo_wchar(CCharT*) : Int32
  fun erasewchar(WCharT*) : Int32
  fun mvadd_wch(Int32, Int32, CCharT*) : Int32
  fun mvadd_wchnstr(Int32, Int32, CCharT*, Int32) : Int32
  fun mvadd_wchstr(Int32, Int32, CCharT*) : Int32
  fun mvaddnwstr(Int32, Int32, WCharT*, Int32) : Int32
  fun mvaddwstr(Int32, Int32, WCharT*) : Int32

  # Background functions
  fun bkgrnd(CCharT*) : Int32
  fun bkgrndset(CCharT*)

  # Misc functions
  fun border_set(CCharT*, CCharT*, CCharT*, CCharT*, CCharT*, CCharT*, CCharT*, CCharT*) : Int32
  fun getbkgrnd(CCharT*) : Int32
  fun hline_set(CCharT*, int) : Int32
  fun key_name(WCharT) : UInt8
  fun killwchar(WCharT) : Int32
  fun mvhline_set(Int32, Int32, CCharT*, int) : Int32
  fun mvvline_set(Int32, Int32, CCharT*, int) : Int32
  fun setcchar(CCharT*, WCharT*, AttrT, NCURSES_PAIRS_T, void *) : Int32
  fun slk_wset(Int32, WCharT*, int) : Int32
  fun term_attrs : AttrT
  fun unget_wch(WCharT) : Int32
  fun vid_attr(AttrT, NCURSES_PAIRS_T, void *) : Int32
  fun vid_puts(AttrT, NCURSES_PAIRS_T, void *, NCURSES_OUTC) : Int32
  fun vline_set(CCharT*, int) : Int32
  fun wunctrl(CCharT*) : WCharT

  # Wrappers for WACS_ constants
  fun wacs_ulcorner = impl_WACS_ULCORNER : Int32
  fun wacs_llcorner = impl_WACS_LLCORNER : Int32
  fun wacs_urcorner = impl_WACS_URCORNER : Int32
  fun wacs_lrcorner = impl_WACS_LRCORNER : Int32
  fun wacs_ltee = impl_WACS_LTEE : Int32
  fun wacs_rtee = impl_WACS_RTEE : Int32
  fun wacs_btee = impl_WACS_BTEE : Int32
  fun wacs_ttee = impl_WACS_TTEE : Int32
  fun wacs_hline = impl_WACS_HLINE : Int32
  fun wacs_vline = impl_WACS_VLINE : Int32
  fun wacs_plus = impl_WACS_PLUS : Int32
  fun wacs_s1 = impl_WACS_S1 : Int32
  fun wacs_s9 = impl_WACS_S9 : Int32
  fun wacs_diamond = impl_WACS_DIAMOND : Int32
  fun wacs_ckboard = impl_WACS_CKBOARD : Int32
  fun wacs_degree = impl_WACS_DEGREE : Int32
  fun wacs_plminus = impl_WACS_PLMINUS : Int32
  fun wacs_bullet = impl_WACS_BULLET : Int32
  fun wacs_larrow = impl_WACS_LARROW : Int32
  fun wacs_rarrow = impl_WACS_RARROW : Int32
  fun wacs_darrow = impl_WACS_DARROW : Int32
  fun wacs_uarrow = impl_WACS_UARROW : Int32
  fun wacs_board = impl_WACS_BOARD : Int32
  fun wacs_lantern = impl_WACS_LANTERN : Int32
  fun wacs_block = impl_WACS_BLOCK : Int32
  fun wacs_s3 = impl_WACS_S3 : Int32
  fun wacs_s7 = impl_WACS_S7 : Int32
  fun wacs_lequal = impl_WACS_LEQUAL : Int32
  fun wacs_gequal = impl_WACS_GEQUAL : Int32
  fun wacs_pi = impl_WACS_PI : Int32
  fun wacs_nequal = impl_WACS_NEQUAL : Int32
  fun wacs_sterling = impl_WACS_STERLING : Int32
  fun wacs_bssb = impl_WACS_BSSB : Int32
  fun wacs_ssbb = impl_WACS_SSBB : Int32
  fun wacs_bbss = impl_WACS_BBSS : Int32
  fun wacs_sbbs = impl_WACS_SBBS : Int32
  fun wacs_sbss = impl_WACS_SBSS : Int32
  fun wacs_sssb = impl_WACS_SSSB : Int32
  fun wacs_ssbs = impl_WACS_SSBS : Int32
  fun wacs_bsss = impl_WACS_BSSS : Int32
  fun wacs_bsbs = impl_WACS_BSBS : Int32
  fun wacs_sbsb = impl_WACS_SBSB : Int32
  fun wacs_ssss = impl_WACS_SSSS : Int32

  {% end %}

  # Custom functions
  fun ncurses_version : Char*
  fun get_ncurses_version(Version*) : Void
end

require "./lib_ncurses/key"
require "./lib_ncurses/mouse"
require "./lib_ncurses/window"
require "./lib_ncurses/menu"
