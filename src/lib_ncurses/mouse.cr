lib LibNCurses
  BUTTON_RELEASED = 0o001
  BUTTON_PRESSED  = 0o002
  BUTTON_CLICKED  = 0o004
  DOUBLE_CLICKED  = 0o010
  TRIPLE_CLICKED  = 0o020
  RESERVED_EVENT  = 0o040

  {% for num in (1..5) %}
  BUTTON{{num.id}}_RELEASED = ncurses_mouse_mask({{num.id}}, BUTTON_RELEASED)
  BUTTON{{num.id}}_PRESSED = ncurses_mouse_mask({{num.id}}, BUTTON_PRESSED)
  BUTTON{{num.id}}_CLICKED = ncurses_mouse_mask({{num.id}}, BUTTON_CLICKED)
  BUTTON{{num.id}}_DOUBLE_CLICKED = ncurses_mouse_mask({{num.id}}, DOUBLE_CLICKED)
  BUTTON{{num.id}}_TRIPLE_CLICKED = ncurses_mouse_mask({{num.id}}, TRIPLE_CLICKED)
  {% end %}

  BUTTON_CTRL            = ncurses_mouse_mask(6, 0o0001)
  BUTTON_SHIFT           = ncurses_mouse_mask(6, 0o0002)
  BUTTON_ALT             = ncurses_mouse_mask(6, 0o0004)
  REPORT_MOUSE_POSITION  = ncurses_mouse_mask(6, 0o0010)

  ALL_MOUSE_EVENTS = (REPORT_MOUSE_POSITION - 1)


  struct MEventT
    id : UInt16
    x : Int32
    y : Int32
    z : Int32
    bstate : UInt32
  end

  alias MEVENT = MEventT*

  fun has_mouse : Bool
  fun getmouse(MEVENT) : Int32
  fun ungetmouse(MEVENT) : Int32
  fun mousemask(MMaskT, MMaskT*) : MMaskT
  fun wenclose(WINDOW, Int32, Int32) : Bool
  fun mouseinterval(Int32) : Int32
  fun wmouse_trafo(WINDOW, Int32*, Int32*, Bool) : Bool
  fun mouse_trafo(Int32*, Int32*, Bool) : Bool

  {% if flag?(:NCURSES_SP_FUNCS) %}
  fun has_mouse_sp(SCREEN) : Bool
  fun getmouse_sp(SCREEN, MEVENT) : Int32
  fun ungetmouse_sp(SCREEN, MEVENT) : Int32
  fun mousemask_sp(SCREEN, MMaskT, MMaskT*) : MMaskT
  fun mouseinterval_sp(SCREEN, Int32)
  {% end %}

end

macro ncurses_mouse_mask(b, m)
  {% num = flag?(:bits32) ? 5 : 6 %}
  ({{m.id}} << (({{b.id}} - 1) * {{num.id}}))
end

macro ncurses_button_release(e, x)
  ({{e.id}} & ncurses_mouse_mask({{x.id}}, 0o001))
end
