@[Link("panel")]
lib LibNCurses

  {% if flag?(:NCURSES_OPAQUE) %}
    type PanelT = Void
  {% else %}
    struct PanelT
      win : WINDOW
      below : PANEL
      above : PANEL
      user : Void*
    end
  {% end %}
  alias PANEL = PanelT*

  fun panel_window(PANEL) : WINDOW
  fun update_panels
  {% for _fun in %w(hide_panel show_panel del_panel top_panel bottom_panel panel_hidden) %}
  fun {{_fun.id}}(PANEL) : Int32
  {% end %}
  fun new_panel(WINDOW) : PANEL
  fun panel_above(PANEL) : PANEL
  fun panel_below(PANEL) : PANEL
  fun set_panel_userptr(PANEL, Void*) : Int32
  fun panel_userptr(PANEL) : Void*
  fun move_panel(PANEL, Int32, Int32) : Int32
  fun replace_panel(PANEL, WINDOW) : Int32

  # NCurses SP Funcs
  # fun ground_panel(SCREEN) : PANEL
  # fun ceiling_panel(SCREEN) : PANEL
  # fun update_panels(SCREEN)
end
