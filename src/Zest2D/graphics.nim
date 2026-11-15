import raylib
import types
import helpers

proc drawRectangle*(x, y, w, h: int32, color: types.Color = White) =
  raylib.drawRectangle(x, y, w, h, color)

proc drawRectangle*(pos, size: types.Vector2, color: types.Color = White) =
  raylib.drawRectangle(pos, size, color)

proc drawCircle*(x, y: int32, radius: float32, color: types.Color = White) =
  raylib.drawCircle(x, y, radius, color)

proc drawCircle*(pos: types.Vector2, radius: float32, color: types.Color = White) =
  raylib.drawCircle(pos, radius, color)