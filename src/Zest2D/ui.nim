import raylib
import helpers
import types
import input

type
  ButtonState* = object
    isHovered*: bool
    isDown*: bool
    isClicked*: bool

proc drawRectangle*(x, y, w, h: int32, color: types.Color = White) =
  raylib.drawRectangle(x, y, w, h, color)

proc drawCircle*(x, y: int32, radius: float32, color: types.Color = White) =
  raylib.drawCircle(x, y, radius, color)

proc drawText*(text: string, x, y, fontSize: int32, color: types.Color = White) =
  raylib.drawText(text, x, y, fontSize, color)

proc drawButton*(
  text: string,
  pos, size: types.Vector2,
  bgColor: types.Color = DarkGray,
  hoverColor: types.Color = Gray,
  textColor: types.Color = White,
  fontSize: int32 = 20
): ButtonState =
  let mouse = input.getMousePosition()
  let hovered = mouse.x >= pos.x and mouse.x <= pos.x + size.x and
                mouse.y >= pos.y and mouse.y <= pos.y + size.y

  let down = hovered and isMouseButtonDown(input.MouseButton.Left)
  let clicked = hovered and isMouseButtonPressed(input.MouseButton.Left)

  let currentBg = if hovered: hoverColor else: bgColor
  drawRectangle(pos.x.int32, pos.y.int32, size.x.int32, size.y.int32, currentBg)

  let textW = raylib.measureText(text, fontSize)
  let textX = pos.x.int32 + (size.x.int32 - textW) div 2
  let textY = pos.y.int32 + (size.y.int32 - fontSize) div 2
  drawText(text, textX, textY, fontSize, textColor)

  ButtonState(
    isHovered: hovered,
    isDown: down,
    isClicked: clicked
  )