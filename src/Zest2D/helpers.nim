import raylib
import types

converter toRlVec2*(v: types.Vector2): raylib.Vector2 {.inline.} =
  raylib.Vector2(x: v.x, y: v.y)

converter toZestVec2*(v: raylib.Vector2): types.Vector2 =
    types.Vector2(x: v.x, y: v.y)

converter toRlCol*(c: types.Color): raylib.Color {.inline.} =
  raylib.Color(r: c.r, g: c.g, b: c.b, a: c.a)

converter toRlCol*(r: types.Rectangle): raylib.Rectangle {.inline.} =
  raylib.Rectangle(x: r.pos.x, y: r.pos.y, width: r.scale.x, height: r.scale.y)



converter toZestTexture*(t: raylib.Texture): types.Texture {.inline.} =
  types.Texture(
    id: t.id,
    width: t.width,
    height: t.height,
    mipmaps: t.mipmaps,
    format: int32(t.format)
  )