import ../Zest2D/core
import ../Zest2D/juice
import ../Zest2D/input
import ../Zest2D/graphics
import ../Zest2D/ui
import ../Zest2D/types

type
  Player = object
    pos: Vector2
    scale: Vector2
    color: Color

var player = Player(pos: Vector2(x: 100.0, y: 100.0), scale: Vector2(x: 10.0, y: 10.0), color: Red)
var stamina: int32 = 200

proc Update(dt: float32) =
    var speed: float32 = 100
    var dirX: int32 = 0
    var dirY: int32 = 0
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
    
    setCameraZoom(5.0)
    setCameraFollow(player.pos, smoothing = 8.0)
    
proc Draw() =
    graphics.drawRectangle(
        player.pos, 
        player.scale, 
        player.color
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

initZest2D(800, 600, "Zest2D Test Window", Update, Draw, drawUi)