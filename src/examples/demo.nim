import ../Zest2D/core
import raylib

var x: int32 = 10
var y: int32 = 10

proc Update(dt: float32) =
    x += 10
    y += 10

proc Draw() =
    drawRectangle(x, y, 10, 10, Red)

initZest2D(800, 600, "Zest2D Test Window", Update, Draw)