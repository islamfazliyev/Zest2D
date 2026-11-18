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

