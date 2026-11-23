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
    color*: Color
    collider*: CircleCol

  Box* = object
    rect*: Rectangle
    rotation*: float32
    color*: Color
    collider*: OBB

var circle1* = Circle(
  pos: Vector2(x: -80, y: -60),
  radius: 12,
  color: Yellow,
  collider: CircleCol(pos: Vector2(x: -80, y: -60), radius: 12)
)

var circle2* = Circle(
  pos: Vector2(x: 80, y: -60),
  radius: 16,
  color: Blue,
  collider: CircleCol(pos: Vector2(x: 80, y: -60), radius: 16)
)

var box1* = Box(
  rect: Rectangle(pos: Vector2(x: -60, y: 20), scale: Vector2(x: 50, y: 25)),
  rotation: 25.0,
  color: Green,
  collider: OBB(rect: Rectangle(pos: Vector2(x: -60, y: 20), scale: Vector2(x: 50, y: 25)), rotation: 25.0)
)

var box2* = Box(
  rect: Rectangle(pos: Vector2(x: 40, y: 15), scale: Vector2(x: 60, y: 30)),
  rotation: -35.0,
  color: Red,
  collider: OBB(rect: Rectangle(pos: Vector2(x: 40, y: 15), scale: Vector2(x: 60, y: 30)), rotation: -35.0)
)

var isCircleHit = false
var isObbHit = false

proc Update(dt: float32) =
  # WASD: Move yellow circle
  if isKeyDown(Key.A): circle1.pos.x -= 120 * dt
  if isKeyDown(Key.D): circle1.pos.x += 120 * dt
  if isKeyDown(Key.W): circle1.pos.y -= 120 * dt
  if isKeyDown(Key.S): circle1.pos.y += 120 * dt

  # Arrow keys: Move green box | Q / E: Rotate box
  if isKeyDown(Key.Left):  box1.rect.pos.x -= 120 * dt
  if isKeyDown(Key.Right): box1.rect.pos.x += 120 * dt
  if isKeyDown(Key.Up):    box1.rect.pos.y -= 120 * dt
  if isKeyDown(Key.Down):  box1.rect.pos.y += 120 * dt
  if isKeyDown(Key.Q):     box1.rotation -= 90 * dt
  if isKeyDown(Key.E):     box1.rotation += 90 * dt

  # Continuously rotate target red box
  box2.rotation += 30 * dt

  # Sync colliders with transforms
  circle1.collider.pos = circle1.pos
  circle2.collider.pos = circle2.pos

  box1.collider.rect = box1.rect
  box1.collider.rotation = box1.rotation
  box2.collider.rect = box2.rect
  box2.collider.rotation = box2.rotation

  # Run collision checks
  isCircleHit = circleCollider(circle1.collider, circle2.collider)
  isObbHit = obbCollider(box1.collider, box2.collider)

  if isCircleHit:
    echo "[Collision] Circle hit detected!"
  if isObbHit:
    echo "[Collision] OBB hit detected!"

proc Draw() =
  # Draw circles (flash white on collision)
  let c1Color = if isCircleHit: White else: circle1.color
  let c2Color = if isCircleHit: White else: circle2.color
  graphics.drawCircle(circle1.pos, circle1.radius, c1Color)
  graphics.drawCircle(circle2.pos, circle2.radius, c2Color)

  # Draw rotating OBB boxes (flash white on collision)
  let b1Color = if isObbHit: White else: box1.color
  let b2Color = if isObbHit: White else: box2.color
  graphics.drawRectangle(box1.rect, box1.rotation, b1Color)
  graphics.drawRectangle(box2.rect, box2.rotation, b2Color)

proc DrawUI() =
  ui.drawText("WASD: Move Circle", 16, 16, 18, White)
  ui.drawText("Arrows: Move Box | Q / E: Rotate Box", 16, 42, 18, White)
  if isCircleHit:
    ui.drawText("CIRCLE COLLISION!", 16, 76, 20, Yellow)
  if isObbHit:
    ui.drawText("OBB COLLISION!", 16, 102, 20, Green)

initCamera2D(zoom = 2.0)
initZest2D(800, 600, "Zest2D Collision Test", Update, Draw, DrawUI, Black)