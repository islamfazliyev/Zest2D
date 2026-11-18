import ../Zest2D/core
import ../Zest2D/juice
import ../Zest2D/input
import ../Zest2D/graphics
import ../Zest2D/ui
import ../Zest2D/types
import ../Zest2D/math

type
  Player = object
    pos: Vector2
    scale: Vector2
    color: Color

type
  Shield = object
    pos: Vector2
    scale: Vector2
    color: Color

type
  Obstacle = object
    pos: Vector2
    scale: Vector2
    color: Color

var player = Player(pos: Vector2(x: 100.0, y: 100.0), scale: Vector2(x: 10.0, y: 10.0), color: Red)
var shield = Player(pos: Vector2(x: 80.0, y: 80.0), scale: Vector2(x: 10.0, y: 10.0), color: Blue)
var obstacle1 = Obstacle(pos: Vector2(x: 150.0, y: 100.0), scale: Vector2(x: 10.0, y: 10.0), color: DarkGray)
var stamina: int32 = 200
var 
    shieldAngle: float32 = 0.0
    shieldPos: Vector2

proc Update(dt: float32) =
    var speed: float32 = 100
    var dirX: int32 = 0
    var dirY: int32 = 0
    let oldPos = player.pos

    
    if input.isKeyDown(Key.Right): 
        player.pos.x += speed * dt 
        dirX = 1
    if input.isKeyDown(Key.Left):  
        player.pos.x -= speed * dt
        dirX = -1
    if input.isKeyDown(Key.Down):  
        player.pos.y += speed * dt
        dirY = 1
    if input.isKeyDown(Key.Up):    
        player.pos.y -= speed * dt
        dirY = -1

    if input.isKeyPressed(Key.Space) and stamina > 0: 
        if dirX == 1: player.pos.x += 40
        if dirX == -1: player.pos.x -= 40
        if dirY == -1: player.pos.y -= 40
        if dirY == 1: player.pos.y += 40
        flash(player.color, Green, 0.3)
        squash(player.scale, -10, -10, 0.2)
        shakeCamera(10.0, 10.0, 0.2)
        stamina -= 10
    
    if overlaps(player.pos, player.scale, obstacle1.pos, obstacle1.scale):
        player.pos = oldPos

    shieldAngle += 4.0 * dt
    let radius: float32 = 18.0
    let center = Vector2(
        x: player.pos.x + 10 / 2.0,
        y: player.pos.y + 10 / 2.0
    )

    shield.pos.x = center.x + cos(shieldAngle) * radius
    shield.pos.y = center.y + sin(shieldAngle) * radius

    setCameraZoom(5.0)
    setCameraFollow(player.pos, smoothing = 8.0)

proc Draw() =
    
    graphics.drawRectangle(
        player.pos, 
        player.scale, 
        player.color
    )

    graphics.drawCircle(
        shield.pos, 
        1, 
        shield.color
    )

    graphics.drawRectangle(
        obstacle1.pos, 
        obstacle1.scale, 
        obstacle1.color
    )

    graphics.drawRectangle(
        Vector2(x: 40, y: 10), 
        Vector2(x: 10.0, y: 10.0), 
        Blue
    )

    graphics.drawRectangle(
        Vector2(x: 60, y: 10), 
        Vector2(x: 10.0, y: 10.0), 
        Green
    )

    graphics.drawRectangle(
        Vector2(x: 80, y: 10), 
        Vector2(x: 10.0, y: 10.0), 
        Yellow
    )


proc drawUi() =
    ui.drawRectangle(10, 10, stamina, 30, Blue)

    # let button = drawButton("PLAY", Vector2(x: 300, y: 250), Vector2(x: 200, y: 50))

    # if button.isClicked:
    #     echo "hello world"

initZest2D(800, 600, "Zest2D Test Window", Update, Draw, drawUi)