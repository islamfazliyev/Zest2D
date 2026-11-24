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

type
  Character* = object
    rect: Rectangle
    rotation: float32
    texture: string
    color: Color

var character = Character(
    rect: Rectangle(pos: Vector2(x:0, y:0), scale: Vector2(x:119, y:229)),
    rotation: 0,
    texture: "src/examples/test.png",
    color: White
)

var charTex: Texture

proc Update(dt: float32) =
  charTex = loadTexture(character.texture)
  


proc Draw() =
    drawTexture(charTex, character.rect, character.rotation, character.color)


initCamera2D(zoom = 1.0)
initZest2D(800, 600, "Zest2D Collision Test", Update, Draw, nil, Black)