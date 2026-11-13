import ../Zest2D/core
import ../Zest2D/juice
import ../Zest2D/input
import raylib

type
  Player = object
    pos: Vector2

var player = Player(pos: Vector2(x: 100.0, y: 100.0))

proc Update(dt: float32) =
    var speed: float32 = 300
    if input.isKeyDown(Key.Right): player.pos.x += speed * dt
    if input.isKeyDown(Key.Left):  player.pos.x -= speed * dt
    if input.isKeyDown(Key.Down):  player.pos.y += speed * dt
    if input.isKeyDown(Key.Up):    player.pos.y -= speed * dt
    if input.isKeyDown(Key.Space): 
        shake(player.pos, 30.0, 30.0, 0.3)
        #shake(mainCamera.offset, 30.0, 30.0, 0.3)
    

    mainCamera.zoom = 5.0
    setCameraFollow(player.pos, smoothing = 8.0)

proc Draw() =
    drawRectangle(
        player.pos, 
        Vector2(x: 10.0, y: 10.0), 
        Red
    )

    drawRectangle(
        Vector2(x: 40, y: 10), 
        Vector2(x: 10.0, y: 10.0), 
        Blue
    )

initZest2D(800, 600, "Zest2D Test Window", Update, Draw)