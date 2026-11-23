import types

type
  CircleCol* = object
    pos*: Vector2
    radius*: float32

proc circleCollider*(a, b: CircleCol): bool {.inline.} =
  let dx = a.pos.x - b.pos.x
  let dy = a.pos.y - b.pos.y
  let ds = (dx * dx) + (dy * dy)
  let r = (a.radius + b.radius) * (a.radius + b.radius)
  ds <= r