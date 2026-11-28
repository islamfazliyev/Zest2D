import ../Zest2D/core
import ../Zest2D/juice
import ../Zest2D/input
import ../Zest2D/graphics
import ../Zest2D/ui
import ../Zest2D/types
import ../Zest2D/helpers
import ../Zest2D/math
import ../Zest2D/audio
import ../Zest2D/collision
import ../Zest2D/textures
import ../Zest2D/animation

var playerPos = types.Vector2(x: 0.0, y: 0.0)
var playerSpeed: float32 = 180.0
var facingLeft = false
var isLoaded = false
var walkAnim: SpriteAnimation

proc initPlayer() =
  let playerSheet = loadTexture("src/examples/test.png")
  walkAnim = newAnimation(playerSheet, frameW = 16, frameH = 16, frameCount = 4, fps = 10.0)
  isLoaded = true

proc Update(dt: float32) =
  if not isLoaded:
    initPlayer()

  var moveDir = types.Vector2(x: 0.0, y: 0.0)

  if isKeyDown(Key.A) or isKeyDown(Key.Left):
    moveDir.x -= 1.0
    facingLeft = true
  if isKeyDown(Key.D) or isKeyDown(Key.Right):
    moveDir.x += 1.0
    facingLeft = false
  if isKeyDown(Key.W) or isKeyDown(Key.Up):
    moveDir.y -= 1.0
  if isKeyDown(Key.S) or isKeyDown(Key.Down):
    moveDir.y += 1.0

  let isMoving = moveDir.x != 0.0 or moveDir.y != 0.0
  if isMoving:
    if moveDir.x != 0.0 and moveDir.y != 0.0:
      moveDir.x *= 0.7071'f32
      moveDir.y *= 0.7071'f32
    playerPos.x += moveDir.x * playerSpeed * dt
    playerPos.y += moveDir.y * playerSpeed * dt
    walkAnim.update(dt)
  else:
    walkAnim.reset()

  setCameraFollow(playerPos, smoothing = 8.0)

  let mouseWorld = getMouseWorldPosition()
  if isMouseButtonPressed(MouseButton.Left):
    echo "World Coordinates: ", mouseWorld.x, ", ", mouseWorld.y

proc Draw() =
  if isLoaded:
    walkAnim.draw(playerPos, scale = 2.0, flipX = facingLeft)

initCamera2D(zoom = 2.0)
initZest2D(800, 600, "Zest2D Animation & World Mouse Test", Update, Draw, nil, Black)