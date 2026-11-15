type
  Vector2* = object
    x*: float32
    y*: float32

  Color* = object
    r*: uint8
    g*: uint8
    b*: uint8
    a*: uint8

proc rgba*(r, g, b: uint8, a: uint8 = 255): Color {.inline.} =
  Color(r: r, g: g, b: b, a: a)

const
  White* = rgba(255, 255, 255)
  Black* = rgba(0, 0, 0)
  Red*   = rgba(230, 41, 55)
  Green* = rgba(0, 228, 48)
  Blue*  = rgba(0, 121, 241)
  Yellow*  = rgba(255, 255, 0)
  Gray*     = rgba(130, 130, 130)
  DarkGray* = rgba(80, 80, 80)