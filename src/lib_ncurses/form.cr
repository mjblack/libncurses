lib LibNCurses

  alias FIELDCELL = Void*
  alias FormOptions = Int32
  alias FieldOptions = Int32

  {% if flag?(:NCURSES_OPAQUE) %}
    type FormT = Void
    type PageT = Void
    type FieldT = Void
    type FieldTypeT = Void
  {% else %}

  {% if flag?(:NCURSES_INTEROP_FUNCS) %}
    union FieldCheck
      ofcheck : Proc(FIELD, Void*, Bool)*
      gfcheck : Proc(FORM, FIELD, Void*, Bool)*
    end

    union CharCheck
      occheck : Proc(Int32, Void*, Bool)*
      gccheck : Proc(Int32, FORM, FIELD, Void*, Bool)*
    end

    union EnumNext
      onext : Proc(FIELD, Void*, Bool)*
      gnext : PRoc(FORM, FIELD, Void*, Bool)*
    end

    union EnumPrev
      oprev : Proc(FIELD, Void*, Bool)*
      gprev : PRoc(FORM, FIELD, Void*, Bool)*
    end
  {% end %}

  struct FormT
    status : UInt16
    rows, cols : Int16
    currow, curcol, toprow, begincol : Int32
    maxfield, maxpage, curpage : Int16
    opts : FormOptions
    win, sub, w : WINDOW
    field : FIELD*
    current : FIELD
    page : PAGE
    usrptr : Void*

    forminit : Proc(FORM, Void)*
    formterm : Proc(FORM, Void)*
    fieldinit : Proc(FORM, Void)*
    fieldterm : Proc(FORM, Void)*
  end

  struct PageT
    pmin : Int16
    pmax : Int16
    smin : Int16
    smax : Int16
  end

  struct FieldT
    status : UInt16
    rows, cols, frow, fcol : Int16
    drows, dcols, maxgrow, nrow : Int32
    nbuf, just, page, index : Int16
    pad : Int32
    fore : CHType
    back : CHType
    opts : FieldOptions
    snext, sprev, link : FIELD
    form : FORM
    type_ : FIELDTYPE
    arg : Void*
    buf : FIELDCELL
    usrptr : Void*
  end

    {% begin %}
      struct FieldTypeT
        status : UInt16
        ref : Int32
        left, right : FIELDTYPE
        makearg : Proc(LibC::VaList, Void*)
        copyarg : Proc(Void*, Void*)
        freearg : Proc(Void*, Void)
        {% if flag?(:NCURSES_INTEROP_FUNCS) %}
          fieldcheck : FieldCheck
          charcheck : CharCheck
          enum_next : EnumNext
          enum_prev : EnumPrev
        {% else %}
          fcheck : Proc(FIELD, Void*, Bool)*
          ccheck : Proc(Int32, Void*, Bool)*
          next_type : Proc(FIELD, Void*, Bool)*
          prev_type : Proc(FIELD, Void*, Bool)*
        {% end %}
      end
    {% end %}
  {% end %}

  alias FORM = FormT*
  alias PAGE = PageT*
  alias FIELD = FieldT*
  alias FIELDTYPE = FieldTypeT*


  $type_alpha   = TYPE_ALPHA : FIELDTYPE
  $type_alnum   = TYPE_ALNUM : FIELDTYPE
  $type_enum    = TYPE_ENUM : FIELDTYPE
  $type_integer = TYPE_INTEGER : FIELDTYPE
  $type_numeric = TYPE_NUMERIC : FIELDTYPE
  $type_regexp  = TYPE_REGEXP : FIELDTYPE
  $type_ipv4    = TYPE_IPV4 : FIELDTYPE

  alias FormHook = Proc(FORM, Void)*

  enum Justification
    None      = 0
    Left      = 1
    Center    = 2
    Right     = 3
  end

  @[Flags]
  enum FieldOption : UInt32
    VISIBLE          = 0x0001
    ACTIVE           = 0x0002
    PUBLIC           = 0x0004
    EDIT             = 0x0008
    WRAP             = 0x0010
    BLANK            = 0x0020
    AUTOSKIP         = 0x0040
    NULLOK           = 0x0080
    PASSOK           = 0x0100
    STATIC           = 0x0200
    DYNAMIC_JUSTIFY  = 0x0400
    NO_LEFT_STRIP    = 0x0800
    EDGE_INSERT_STAY = 0x1000
    INPUT_LIMIT      = 0x2000
  end

  @[Flags]
  enum FormOption : UInt32
    NL_OVERLOAD = 0x0001
    BS_OVERLOAD = 0x0002
  end

  REQ_NEXT_PAGE    = (KEY_MAX + 1)
  REQ_PREV_PAGE    = (KEY_MAX + 2)
  REQ_FIRST_PAGE   = (KEY_MAX + 3)
  REQ_LAST_PAGE    = (KEY_MAX + 4)

  REQ_NEXT_FIELD    = (KEY_MAX + 5)
  REQ_PREV_FIELD    = (KEY_MAX + 6)
  REQ_FIRST_FIELD   = (KEY_MAX + 7)
  REQ_LAST_FIELD    = (KEY_MAX + 8)
  REQ_SNEXT_FIELD   = (KEY_MAX + 9)
  REQ_SPREV_FIELD   = (KEY_MAX + 10)
  REQ_SFIRST_FIELD  = (KEY_MAX + 11)
  REQ_SLAST_FIELD   = (KEY_MAX + 12)
  REQ_LEFT_FIELD    = (KEY_MAX + 13)
  REQ_RIGHT_FIELD   = (KEY_MAX + 14)
  REQ_UP_FIELD      = (KEY_MAX + 15)
  REQ_DOWN_FIELD    = (KEY_MAX + 16)

  REQ_NEXT_CHAR     = (KEY_MAX + 17)
  REQ_PREV_CHAR     = (KEY_MAX + 18)
  REQ_NEXT_LINE     = (KEY_MAX + 19)
  REQ_PREV_LINE     = (KEY_MAX + 20)
  REQ_NEXT_WORD     = (KEY_MAX + 21)
  REQ_PREV_WORD     = (KEY_MAX + 22)
  REQ_BEG_FIELD     = (KEY_MAX + 23)
  REQ_END_FIELD     = (KEY_MAX + 24)
  REQ_BEG_LINE      = (KEY_MAX + 25)
  REQ_END_LINE      = (KEY_MAX + 26)
  REQ_LEFT_CHAR     = (KEY_MAX + 27)
  REQ_RIGHT_CHAR    = (KEY_MAX + 28)
  REQ_UP_CHAR       = (KEY_MAX + 29)
  REQ_DOWN_CHAR     = (KEY_MAX + 30)

  REQ_NEW_LINE      = (KEY_MAX + 31)
  REQ_INS_CHAR      = (KEY_MAX + 32)
  REQ_INS_LINE      = (KEY_MAX + 33)
  REQ_DEL_CHAR      = (KEY_MAX + 34)
  REQ_DEL_PREV      = (KEY_MAX + 35)
  REQ_DEL_LINE      = (KEY_MAX + 36)
  REQ_DEL_WORD      = (KEY_MAX + 37)
  REQ_CLR_EOL       = (KEY_MAX + 38)
  REQ_CLR_EOF       = (KEY_MAX + 39)
  REQ_CLR_FIELD     = (KEY_MAX + 40)
  REQ_OVL_MODE      = (KEY_MAX + 41)
  REQ_INS_MODE      = (KEY_MAX + 42)
  REQ_SCR_FLINE     = (KEY_MAX + 43)
  REQ_SCR_BLINE     = (KEY_MAX + 44)
  REQ_SCR_FPAGE     = (KEY_MAX + 45)
  REQ_SCR_BPAGE     = (KEY_MAX + 46)
  REQ_SCR_FHPAGE    = (KEY_MAX + 47)
  REQ_SCR_BHPAGE    = (KEY_MAX + 48)
  REQ_SCR_FCHAR     = (KEY_MAX + 49)
  REQ_SCR_BCHAR     = (KEY_MAX + 50)
  REQ_SCR_HFLINE    = (KEY_MAX + 51)
  REQ_SCR_HBLINE    = (KEY_MAX + 52)
  REQ_SCR_HFHALF    = (KEY_MAX + 53)
  REQ_SCR_HBHALF    = (KEY_MAX + 54)

  REQ_VALIDATION    = (KEY_MAX + 55)
  REQ_NEXT_CHOICE   = (KEY_MAX + 56)
  REQ_PREV_CHOICE   = (KEY_MAX + 57)

  MIN_FORM_COMMAND  = (KEY_MAX + 1)
  MAX_FORM_COMMAND  = (KEY_MAX + 57)




  # Field Routines
  fun new_field(Int32, Int32, Int32, Int32, Int32, Int32) : FIELD
  fun dup_field(FIELD, Int32, Int32) : FIELD
  fun link_field(FIELD, Int32, Int32) : FIELD

  fun free_field(FIELD) : Int32
  fun field_info(FIELD, Int32*, Int32*, Int32*, Int32*, Int32*, Int32*) : Int32
  fun dynamic_field_info(FIELD, Int32, Int32, Int32) : Int32
  fun set_max_field(FIELD, Int32) : Int32
  fun move_field(FIELD, Int32, Int32) : Int32
  fun set_field_type(FIELD, FIELDTYPE, ...) : Int32
  fun set_new_page(FIELD, Bool) : Int32
  fun set_field_just(FIELD, Bool) : Int32
  fun field_just(FIELD) : Int32
  fun set_field_fore(FIELD, CHType) : Int32
  fun set_field_back(FIELD, CHType) : Int32
  fun set_field_pad(FIELD, Int32) : Int32
  fun field_pad(FIELD) : Int32
  fun set_field_buffer(FIELD, Int32, LibC::Char*) : Int32
  fun set_field_status(FIELD, Bool) : Int32
  fun set_field_userptr(FIELD, Void*) : Int32
  fun set_field_opts(FIELD, FieldOptions) : Int32
  fun field_opts_on(FIELD, FieldOptions) : Int32
  fun field_opts_off(FIELD, FieldOptions) : Int32
  fun field_fore(FIELD) : CHType
  fun field_back(FIELD) : CHType
  fun new_page(FIELD) : Bool
  fun field_status(FIELD) : Bool
  fun field_arg(FIELD) : Void*
  fun field_userptr(FIELD) : Void*
  fun field_type(FIELD) : FIELDTYPE
  fun field_buffer(FIELD, Int32) : LibC::Char*
  fun field_opts(FIELD) : FieldOptions

  # Form Routines

  fun new_form(FIELD*) : FORM

  fun form_fields(FORM) : FIELD*
  fun current_field(FORM) : FIELD
  fun form_win(FORM) : WINDOW
  fun form_sub(FORM) : WINDOW

  {% for _fun in [form, field] %}
  fun {{_fun.id}}_init(FORM) : FormHook
  fun {{_fun.id}}_term(FORM) : FormHook
  {% end %}

  {% for _fun in [free_form, field_count, unfocus_current_field, form_page, post_form, unpost_form, pos_form_cursor, ] %}
  fun {{_fun.id}}(FORM) : Int32
  {% end %}

  fun set_form_fields(FORM, FIELD*) : Int32
  fun set_form_win(FORM, WINDOW) : Int32
  fun set_form_sub(FORM, WINDOW) : Int32
  fun set_current_field(FORM, FIELD) : Int32
  fun set_form_page(FORM, Int32) : Int32
  fun scale_form(FORM, Int32*, Int32*) : Int32

  {% for _fun in [set_form_init, set_form_term, set_field_init, set_field_term] %}
  fun {{_fun.id}}(FORM, FormHook) : Int32
  {% end %}

  fun form_driver(FORM, Int32) : Int32
  fun form_driver_w(FORM, Int32, WCharT) : Int32
  fun set_form_userptr(FORM, Void*) : Int32

  {% for _fun in [set_form_opts, form_opts_on, form_opts_off] %}
  fun {{_fun.id}}(FORM, FormOptions) : Int32
  {% end %}

  fun form_request_by_name(LibC::Char*) : Int32
  fun form_request_name(Int32) : LibC::Char*
  fun form_userptr(FORM) : Void*
  fun form_opts(FORM) : FormOptions
  fun data_ahead(FORM) : Bool
  fun data_behind(FORM) : Bool

  # SP Funs
  fun new_form_sp(SCREEN, FIELD*) : FORM
end
