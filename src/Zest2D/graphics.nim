import raylib

proc drawRectangle*(x, y, w, h: int32, color: Color = White) =
  raylib.drawRectangle(x, y, w, h, color)

proc drawRectangle*(pos, size: Vector2, color: Color = White) =
  raylib.drawRectangle(pos, size, color)

proc drawCircle*(x, y: int32, radius: float32, color: Color = White) =
  raylib.drawCircle(x, y, radius, color)

proc drawCircle*(pos: Vector2, radius: float32, color: Color = White) =
  raylib.drawCircle(pos, radius, color)