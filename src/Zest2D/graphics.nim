import raylib
import types
import helpers

proc drawRectangle*(x, y, w, h: int32, color: types.Color = White) =
  raylib.drawRectangle(x, y, w, h, color)

proc drawRectangle*(pos, size: types.Vector2, color: types.Color = White) =
  raylib.drawRectangle(pos, size, color)

proc drawRectangle*(rect: types.Rectangle, rotation: float32, color: types.Color = White, origin: types.Vector2 = types.Vector2(x: rect.scale.x / 2, y: rect.scale.y / 2)) =
  let adjustedRect = raylib.Rectangle(
    x: rect.pos.x + origin.x,
    y: rect.pos.y + origin.y,
    width: rect.scale.x,
    height: rect.scale.y
  )
  raylib.drawRectangle(adjustedRect, origin, rotation, color)

proc drawOutlinedRectangle*(
  rect: types.Rectangle,
  rotation: float32 = 0.0,
  fillColor: types.Color = White,
  outlineColor: types.Color = Black,
  outlineThickness: float32 = 2.0
) =
  let outlineRect = types.Rectangle(
    pos: types.Vector2(
      x: rect.pos.x - outlineThickness,
      y: rect.pos.y - outlineThickness
    ),
    scale: types.Vector2(
      x: rect.scale.x + outlineThickness * 2.0,
      y: rect.scale.y + outlineThickness * 2.0
    )
  )

  drawRectangle(outlineRect, rotation, outlineColor)
  drawRectangle(rect, rotation, fillColor)

proc drawCircle*(x, y: int32, radius: float32, color: types.Color = White) =
  raylib.drawCircle(x, y, radius, color)

proc drawCircle*(pos: types.Vector2, radius: float32, color: types.Color = White) =
  raylib.drawCircle(pos, radius, color)

proc drawTexture*(texture: types.Texture, source: types.Rectangle, dest: types.Rectangle, origin: types.Vector2, rotation: float32, color: types.Color) =
  let rlTexPtr = cast[ptr raylib.Texture](unsafeAddr texture)
  raylib.drawTexture(rlTexPtr[], source, dest, origin, rotation, color)

proc drawTexture*(texture: types.Texture, dest: types.Rectangle, rotation: float32 = 0.0'f32, color: types.Color = White) =
  let rlTexPtr = cast[ptr raylib.Texture](unsafeAddr texture)
  let source = types.Rectangle(pos: types.Vector2(x: 0, y: 0), scale: types.Vector2(x: float32(texture.width), y: float32(texture.height)))
  let origin = types.Vector2(x: dest.scale.x * 0.5'f32, y: dest.scale.y * 0.5'f32)
  let centeredDest = types.Rectangle(
    pos: types.Vector2(x: dest.pos.x + origin.x, y: dest.pos.y + origin.y),
    scale: dest.scale
  )
  raylib.drawTexture(rlTexPtr[], source, centeredDest, origin, rotation, color)