import raylib

proc initZest2D*(
  screenWidth: int32, 
  screenHeight: int32, 
  name: string,
  update: proc(dt: float32), # Update callback (gets dt)
  draw: proc()               # Draw callback
) =
    initWindow(screenWidth, screenHeight, name)
    setTargetFPS(60)
    while not windowShouldClose():
        let dt = getFrameTime()
        if not update.isNil:
            update(dt)

        beginDrawing()
        clearBackground(RayWhite)
        if not draw.isNil:
            draw()
        endDrawing()
    closeWindow()