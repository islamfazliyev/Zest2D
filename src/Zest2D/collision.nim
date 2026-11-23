import types
import math

type
  CircleCol* = object
    pos*: Vector2
    radius*: float32

type
  OBB* = object
    rect*: types.Rectangle
    rotation*: float32

proc circleCollider*(a, b: CircleCol): bool {.inline.} =
  let dx = a.pos.x - b.pos.x
  let dy = a.pos.y - b.pos.y
  let ds = (dx * dx) + (dy * dy)
  let r = (a.radius + b.radius) * (a.radius + b.radius)
  ds <= r

proc getCorners(obb: OBB): array[4, Vector2] {.inline.} =
  let hw = obb.rect.scale.x * 0.5'f32
  let hh = obb.rect.scale.y * 0.5'f32
  let cx = obb.rect.pos.x + hw
  let cy = obb.rect.pos.y + hh

  let dir = directionFromAngle(obb.rotation)

  let localCorners = [
    Vector2(x: -hw, y: -hh),
    Vector2(x:  hw, y: -hh),
    Vector2(x:  hw, y:  hh),
    Vector2(x: -hw, y:  hh)
  ]

  for i in 0 .. 3:
    let lx = localCorners[i].x
    let ly = localCorners[i].y
    result[i] = Vector2(
      x: cx + (lx * dir.x - ly * dir.y),
      y: cy + (lx * dir.y + ly * dir.x)
    )

proc projectOntoAxis(corners: array[4, Vector2], axis: Vector2): tuple[min, max: float32] {.inline.} =
  var minProj = dot(corners[0], axis)
  var maxProj = minProj
  for i in 1 .. 3:
    let p = dot(corners[i], axis)
    if p < minProj: minProj = p
    if p > maxProj: maxProj = p
  (minProj, maxProj)

proc obbCollider*(a, b: OBB): bool =
  let cornersA = getCorners(a)
  let cornersB = getCorners(b)

  let dirA = directionFromAngle(a.rotation)
  let dirB = directionFromAngle(b.rotation)

  let axes = [
    dirA,
    Vector2(x: -dirA.y, y: dirA.x),
    dirB,
    Vector2(x: -dirB.y, y: dirB.x)
  ]

  for axis in axes:
    let (minA, maxA) = projectOntoAxis(cornersA, axis)
    let (minB, maxB) = projectOntoAxis(cornersB, axis)

    if maxA < minB or maxB < minA:
      return false

  return true

proc obbCollider*(rectA: types.Rectangle, rotA: float32, rectB: types.Rectangle, rotB: float32): bool {.inline.} =
  obbCollider(OBB(rect: rectA, rotation: rotA), OBB(rect: rectB, rotation: rotB))