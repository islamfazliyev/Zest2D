proc lerp*(a, b, t: float32): float32 =
    a + (b - a) * t