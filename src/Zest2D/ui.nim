import raylib
import helpers
import types

proc drawRectangle*(x, y, w, h: int32, color: types.Color = White) =
  raylib.drawRectangle(x, y, w, h, color)

proc drawCircle*(x, y: int32, radius: float32, color: types.Color = White) =
  raylib.drawCircle(x, y, radius, color)

proc drawText*(text: string, x, y, fontSize: int32, color: types.Color = White) =
  raylib.drawText(text, x, y, fontSize, color)