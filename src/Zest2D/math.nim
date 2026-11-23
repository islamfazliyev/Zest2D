import types
import std/math as stdmath

const
  Pi* = float32(stdmath.PI)
  Tau* = float32(stdmath.TAU)
  Deg2Rad* = Pi / 180.0'f32
  Rad2Deg* = 180.0'f32 / Pi


proc sin*(radians: float32): float32 {.inline.} =
  stdmath.sin(radians)

proc cos*(radians: float32): float32 {.inline.} =
  stdmath.cos(radians)

proc sinDeg*(degrees: float32): float32 {.inline.} =
  stdmath.sin(degrees * Deg2Rad)

proc cosDeg*(degrees: float32): float32 {.inline.} =
  stdmath.cos(degrees * Deg2Rad)

proc lerp*(a, b, t: float32): float32 {.inline.} =
    a + (b - a) * t

proc clamp*(val, min, max: float32): float32 {.inline.} =
  result = val
  if result > max: result = max
  if result < min: result = min

proc smoothstep*(t: float32): float32 {.inline.} =
    t * t * (3.0'f32 - 2.0'f32 * t)

proc arch*(t: float32): float32 {.inline.} =
    let a = 4.0'f32 * t * (1.0'f32 - t)
    return a * a

proc overlaps*(posA, sizeA, posB, sizeB: Vector2): bool {.inline.} =
    posA.x < posB.x + sizeB.x and
    posA.x + sizeA.x > posB.x and
    posA.y < posB.y + sizeB.y and
    posA.y + sizeA.y > posB.y

proc overlaps*(rect1, rect2: types.Rectangle): bool {.inline.} =
    rect1.pos.x < rect2.pos.x + rect2.scale.x and
    rect1.pos.x + rect1.scale.x > rect2.pos.x and
    rect1.pos.y < rect2.pos.y + rect2.scale.y and
    rect1.pos.y + rect1.scale.y > rect2.pos.y

