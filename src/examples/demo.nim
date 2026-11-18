import ../Zest2D/core
import ../Zest2D/juice
import ../Zest2D/input
import ../Zest2D/graphics
import ../Zest2D/ui
import ../Zest2D/types
import ../Zest2D/math
import ../Zest2D/audio

type
  Player = object
    rect: Rectangle
    rotation: float32
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

var player = Player(rect: Rectangle(pos: Vector2(x: 100, y: 100), scale: Vector2(x: 10, y: 10)), rotation: 0.0, color: Red)
var shield = Shield(pos: Vector2(x: 80.0, y: 80.0), scale: Vector2(x: 10.0, y: 10.0), color: Blue)
var obstacle1 = Obstacle(pos: Vector2(x: 150.0, y: 100.0), scale: Vector2(x: 10.0, y: 10.0), color: DarkGray)
var stamina: int32 = 3000
var 
    shieldAngle: float32 = 0.0
    shieldPos: Vector2

let sound = "src/examples/pickupCoin.wav"

proc Update(dt: float32) =
    var speed: float32 = 100
    var dirX: int32 = 0
    var dirY: int32 = 0
    let oldPos = player.rect.pos
    

    
    if input.isKeyDown(Key.Right): 
        player.rect.pos.x += speed * dt 
        dirX = 1
    if input.isKeyDown(Key.Left):  
        player.rect.pos.x -= speed * dt
        dirX = -1
    if input.isKeyDown(Key.Down):  
        player.rect.pos.y += speed * dt
        dirY = 1
    if input.isKeyDown(Key.Up):    
        player.rect.pos.y -= speed * dt
        dirY = -1

    if input.isKeyPressed(Key.Space) and stamina > 0: 
        if dirX == 1: player.rect.pos.x += 40
        if dirX == -1: player.rect.pos.x -= 40
        if dirY == -1: player.rect.pos.y -= 40
        if dirY == 1: player.rect.pos.y += 40
        flash(player.color, Green, 0.3)
        squash(player.rect.scale, -10, -10, 0.2)
        shakeCamera(10.0, 10.0, 0.2)
        stamina -= 10
        playAudioOnce(sound)

    
    if overlaps(player.rect.pos, player.rect.scale, obstacle1.pos, obstacle1.scale):
        player.rect.pos = oldPos

    shieldAngle += 4.0 * dt
    let radius: float32 = 18.0
    let center = Vector2(
        x: player.rect.pos.x + 10 / 2.0,
        y: player.rect.pos.y + 10 / 2.0
    )

    shield.pos.x = center.x + cos(shieldAngle) * radius
    shield.pos.y = center.y + sin(shieldAngle) * radius

    setCameraZoom(5.0)
    setCameraFollow(player.rect.pos, smoothing = 8.0)

proc Draw() =
    
    graphics.drawOutlinedRectangle(
        player.rect,
        player.rotation,
        player.color,
        rgba(255, 186, 76, 255),
        1.0
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