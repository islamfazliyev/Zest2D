import raylib
import std/random
randomize()

type 
    ShakeInstance = object
        target: ptr Vector2
        basePos: Vector2
        amountX: float32
        amountY: float32
        trauma: float32
        decay: float32

var activeShakes: seq[ShakeInstance] = @[]

proc shake*(
    targetObj: var Vector2,
    shakeAmountX: float32,
    shakeAmountY: float32,
    duration: float32 = 0.3,

) =
    activeShakes.add(ShakeInstance(
        target: addr targetObj,
        basePos: targetObj,
        amountX: shakeAmountX,
        amountY: shakeAmountY,
        trauma: 1.0,
        decay: 1.0 / duration
    ))


proc updateJuice*(dt: float32) =
    var i = activeShakes.high
    while i >= 0:
        activeShakes[i].target[].x = activeShakes[i].basePos.x
        activeShakes[i].target[].y = activeShakes[i].basePos.y

        activeShakes[i].trauma -= activeShakes[i].decay * dt

        if activeShakes[i].trauma <= 0.0:
            activeShakes.del(i)
        else:
            let shakePower = activeShakes[i].trauma * activeShakes[i].trauma

            let dirX = (rand(1.0).float32 * 2.0) - 1.0
            let dirY = (rand(1.0).float32 * 2.0) - 1.0

            activeShakes[i].target[].x += activeShakes[i].amountX * shakePower * dirX
            activeShakes[i].target[].y += activeShakes[i].amountY * shakePower * dirY
        
        dec(i)
    