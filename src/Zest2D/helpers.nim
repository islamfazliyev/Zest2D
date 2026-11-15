import raylib
import types

converter toRlVec2*(v: types.Vector2): raylib.Vector2 {.inline.} =
  raylib.Vector2(x: v.x, y: v.y)

converter toRlCol*(c: types.Color): raylib.Color {.inline.} =
  raylib.Color(r: c.r, g: c.g, b: c.b, a: c.a)