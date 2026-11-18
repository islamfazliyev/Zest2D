import raylib
import types

converter toRlVec2*(v: types.Vector2): raylib.Vector2 {.inline.} =
  raylib.Vector2(x: v.x, y: v.y)

converter toRlCol*(c: types.Color): raylib.Color {.inline.} =
  raylib.Color(r: c.r, g: c.g, b: c.b, a: c.a)

converter toRlCol*(r: types.Rectangle): raylib.Rectangle {.inline.} =
  raylib.Rectangle(x: r.pos.x, y: r.pos.y, width: r.scale.x, height: r.scale.y)
