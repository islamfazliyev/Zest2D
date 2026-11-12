import raylib
import math
import juice

var mainCamera* = Camera2D(
    target: Vector2(x: 0, y: 0),
    offset: Vector2(x: 0, y: 0),
    rotation: 0.0,
    zoom: 1.0
)

var cameraTarget*: Vector2 = Vector2(x: 0, y: 0)
var useCameraFollow*: bool = false
var cameraSmoothing*: float32 = 8.0

proc setCameraFollow*(target: Vector2, smoothing: float32 = 8.0) =
    cameraTarget = target
    cameraSmoothing = smoothing
    useCameraFollow = true

proc initCamera2D*(
    target: Vector2 = Vector2(x: 0, y: 0),
    offset: Vector2 = Vector2(x: 0, y: 0),
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
  draw: proc()               # Draw callback
) =
    initWindow(screenWidth, screenHeight, name)
    setTargetFPS(60)
    mainCamera.offset = Vector2(x: screenWidth.float32 / 2.0, y: screenHeight.float32 / 2.0)
    while not windowShouldClose():
        let dt = getFrameTime()

        if not update.isNil:
            update(dt)

        updateJuice(dt)

        if useCameraFollow:
            let factor = min(1.0, cameraSmoothing * dt)
            mainCamera.target.x = lerp(mainCamera.target.x, cameraTarget.x, factor)
            mainCamera.target.y = lerp(mainCamera.target.y, cameraTarget.y, factor)

        beginDrawing()
        clearBackground(RayWhite)
        beginMode2D(mainCamera)
        if not draw.isNil:
            draw()
        endMode2D()
        endDrawing()
    closeWindow()

