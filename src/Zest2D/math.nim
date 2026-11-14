proc lerp*(a, b, t: float32): float32 =
    a + (b - a) * t

proc smoothstep*(t: float32): float32 =
    t * t * (3.0 - 2.0 * t)

proc arch*(t: float32): float32 =
    let a = 4.0 * t * (1.0 - t)
    return a * a