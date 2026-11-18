import raylib
import math
import juice
import types
import helpers
import audio

var mainCamera* = Camera2D(
    target: types.Vector2(x: 0, y: 0),
    offset: types.Vector2(x: 0, y: 0),
    rotation: 0.0,
    zoom: 1.0
)

var cameraTarget*: types.Vector2 = types.Vector2(x: 0, y: 0)
var cameraShakeOffset: types.Vector2 = types.Vector2(x: 0, y: 0)
var useCameraFollow*: bool = false
var cameraSmoothing*: float32 = 8.0

proc setCameraFollow*(target: types.Vector2, smoothing: float32 = 8.0) =
    cameraTarget = target
    cameraSmoothing = smoothing
    useCameraFollow = true

proc setCameraZoom*(zoom: float32) =
    mainCamera.zoom = zoom

proc shakeCamera*(amountX, amountY: float32, duration: float32 = 0.3) =
    cameraShakeOffset = types.Vector2(x: 0, y: 0)
    shake(cameraShakeOffset, amountX, amountY, duration)

proc initCamera2D*(
    target: types.Vector2 = types.Vector2(x: 0, y: 0),
    offset: types.Vector2 = types.Vector2(x: 0, y: 0),
    rotation: float32 = 0.0,
    zoom: float32 = 3.0
) =
    mainCamera.target = target
    mainCamera.offset = offset
    mainCamera.rotation = rotation
    mainCamera.zoom = zoom

proc initZest2D*(
  screenWidth: int32, 
  screenHeight: int32, 
  name: string,
  update: proc(dt: float32), # Update callback (gets dt)
  draw: proc(),               # Draw callback
  drawUi: proc() = nil,               # Draw ui callback
  backgroundClear: types.Color = White,
) =
    initWindow(screenWidth, screenHeight, name)
    initAudioDevice()
    setTargetFPS(60)
    let baseOffset = types.Vector2(x: screenWidth.float32 / 2.0, y: screenHeight.float32 / 2.0)
    mainCamera.offset = baseOffset
    
    while not windowShouldClose():
        let dt = getFrameTime()

        if not update.isNil:
            update(dt)

        updateJuice(dt)
        updateAudio()

        if useCameraFollow:
            let factor = min(1.0, cameraSmoothing * dt)
            mainCamera.target.x = lerp(mainCamera.target.x, cameraTarget.x, factor)
            mainCamera.target.y = lerp(mainCamera.target.y, cameraTarget.y, factor)

        mainCamera.offset.x = baseOffset.x + cameraShakeOffset.x
        mainCamera.offset.y = baseOffset.y + cameraShakeOffset.y

        beginDrawing()
        clearBackground(backgroundClear)
        beginMode2D(mainCamera)
        if not draw.isNil:
            draw()
        endMode2D()
        if not drawUi.isNil:
            drawUi()
        endDrawing()
    audio.clear()
    closeAudioDevice()
    closeWindow()

