import math
import types
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

type 
    SquashInstance = object
        target: ptr Vector2
        baseScale: Vector2
        amountX: float32
        amountY: float32
        ping: float32
        pong: float32

type 
    FlashInstance = object
        target: ptr Color
        baseColor: Color
        flashColor: Color
        ping: float32
        pong: float32

var activeShakes: seq[ShakeInstance] = @[]
var activeSquashes: seq[SquashInstance] = @[]
var activeFlashes: seq[FlashInstance] = @[]

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

proc squash*(
    targetObj: var Vector2,
    squashAmountX: float32,
    squashAmountY: float32,
    duration: float32 = 0.3,

) =
    activeSquashes.add(SquashInstance(
        target: addr targetObj,
        baseScale: targetObj,
        amountX: squashAmountX,
        amountY: squashAmountY,
        ping: 1.0,
        pong: 1.0 / duration,
        
    ))

proc flash*(
    targetObj: var Color,
    flashColor: Color,
    duration: float32 = 0.3,

) =
    activeFlashes.add(FlashInstance(
        target: addr targetObj,
        baseColor: targetObj,
        flashColor: flashColor,
        ping: 1.0,
        pong: 1.0 / duration,
        
    ))


proc updateJuice*(dt: float32) =
    var i = activeShakes.high
    var s = activeSquashes.high
    var f = activeFlashes.high
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
    
    while s >= 0:
        activeSquashes[s].target[].x = activeSquashes[s].baseScale.x
        activeSquashes[s].target[].y = activeSquashes[s].baseScale.y

        activeSquashes[s].ping -= activeSquashes[s].pong * dt
        
        if activeSquashes[s].ping <= 0:
            activeSquashes.del(s)
        else:
            let progress = 1.0 - activeSquashes[s].ping
            let curve = arch(progress)
            activeSquashes[s].target[].x += activeSquashes[s].amountX * curve
            activeSquashes[s].target[].y += activeSquashes[s].amountY * curve
        
        dec(s)
    
    while f >= 0:
        activeFlashes[f].target[] = activeFlashes[f].baseColor

        activeFlashes[f].ping -= activeFlashes[f].pong * dt

        if activeFlashes[f].ping <= 0:
            activeFlashes.del(f)
        else:
            let progress = 1.0 - activeFlashes[f].ping
            let curve = arch(progress)
            
            if curve > 0.50 and curve < 0.70:
                activeFlashes[f].target[] = activeFlashes[f].flashColor
            else:
                activeFlashes[f].target[] = activeFlashes[f].baseColor 
        
        dec(f)
    