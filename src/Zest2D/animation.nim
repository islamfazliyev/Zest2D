import graphics, types

proc newAnimation*(tex: types.Texture, frameW, frameH: float32, frameCount: int, fps: float32 = 12.0, loop: bool = true): SpriteAnimation =
    let cols = max(1, int(tex.width.float32 / frameW))
    SpriteAnimation(
        texture: tex,
        frameWidth: frameW,
        frameHeight: frameH,
        frameCount: frameCount,
        columns: cols,
        fps: fps,
        currentFrame: 0,
        timer: 0.0,
        loop: loop,
        finished: false
    )

proc update*(anim: var SpriteAnimation, dt: float32) =
    if anim.finished or anim.frameCount <= 1 or anim.fps <= 0.0:
        return

    anim.timer += dt
    let frameDuration = 1.0'f32 / anim.fps

    while anim.timer >= frameDuration:
        anim.timer -= frameDuration
        inc anim.currentFrame

        if anim.currentFrame >= anim.frameCount:
            if anim.loop:
                anim.currentFrame = 0
            else:
                anim.currentFrame = anim.frameCount - 1
                anim.finished = true
                break

proc reset*(anim: var SpriteAnimation) =
    anim.currentFrame = 0
    anim.timer = 0.0
    anim.finished = false

proc draw*(anim: SpriteAnimation, pos: types.Vector2, scale: float32 = 1.0, flipX: bool = false, rotation: float32 = 0.0, tint: types.Color = types.White) =
    let col = anim.currentFrame mod anim.columns
    let row = anim.currentFrame div anim.columns

    let src = types.Rectangle(
        pos: types.Vector2(x: float32(col) * anim.frameWidth, y: float32(row) * anim.frameHeight),
        scale: types.Vector2(x: if flipX: -anim.frameWidth else: anim.frameWidth, y: anim.frameHeight)
    )
    let dest = types.Rectangle(
        pos: pos,
        scale: types.Vector2(x: anim.frameWidth * scale, y: anim.frameHeight * scale)
    )
    drawTexture(anim.texture, src, dest, types.Vector2(x: dest.scale.x / 2, y: dest.scale.y / 2), rotation, tint)
