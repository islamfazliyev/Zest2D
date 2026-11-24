proc cooldown*(duration: var float32, dt: float32): bool {.inline.} =
  if duration > 0.0'f32:
    duration -= dt
    if duration <= 0.0'f32:
      duration = 0.0'f32
      return true
  return false