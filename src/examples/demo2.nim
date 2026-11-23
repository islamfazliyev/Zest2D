import ../Zest2D/core
import ../Zest2D/juice
import ../Zest2D/input
import ../Zest2D/graphics
import ../Zest2D/ui
import ../Zest2D/types
import ../Zest2D/math
import ../Zest2D/audio
import ../Zest2D/collision

type
    Circle* = object
        pos*: Vector2
        radius*: float32
        color: Color
        collider*: CircleCol


var circle* = Circle(
    pos: Vector2(x: 10, y: 10),
    radius: 10,
    color: Yellow,
    collider: CircleCol(pos: Vector2(x: 10, y: 10), radius: 10)
)

var circle2* = Circle(
    pos: Vector2(x: 40, y: 10),
    radius: 10,
    color: Blue,
    collider: CircleCol(pos: Vector2(x: 40, y: 10), radius: 10)
)

proc Update(dt: float32) =
    if isKeyDown(Key.A): circle.pos.x -= 100 * dt
    if isKeyDown(Key.D): circle.pos.x += 100 * dt
    
    circle.collider.pos = circle.pos
    circle.collider.radius = circle.radius
    circle2.collider.pos = circle2.pos

    if circleCollider(circle.collider, circle2.collider):
        echo "Çarpıştı!"

proc Draw() =
    graphics.drawCircle(circle.pos, circle.radius, circle.color)
    graphics.drawCircle(circle2.pos, circle2.radius, circle2.color)

initZest2D(800, 600, "Zest2D Test Window", Update, Draw)