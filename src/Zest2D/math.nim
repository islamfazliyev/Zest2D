import types

proc lerp*(a, b, t: float32): float32 =
    a + (b - a) * t

proc smoothstep*(t: float32): float32 =
    t * t * (3.0 - 2.0 * t)

proc arch*(t: float32): float32 =
    let a = 4.0 * t * (1.0 - t)
    return a * a

proc overlaps*(posA, sizeA, posB, sizeB: Vector2): bool =
    posA.x < posB.x + sizeB.x and
    posA.x + sizeA.x > posB.x and
    posA.y < posB.y + sizeB.y and
    posA.y + sizeA.y > posB.y