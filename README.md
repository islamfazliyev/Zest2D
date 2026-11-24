# Zest2D

**Zest2D** is a lightweight, fast, and battery-included 2D game framework written in **Nim**, powered by **Raylib** (`naylib`).

Designed for rapid prototyping and game jams, Zest2D abstracts away boilerplate window/loop management and brings built-in **game feel ("juice")**, **SAT-based OBB & circle collision detection**, **smooth 2D camera following**, and **automatic asset caching** out of the box.

---

## Features

- **Minimal Boilerplate Loop (`core`):** Single-call initialization (`initZest2D`) handling the window, audio device, delta-time updates, 2D camera space, and separate world/UI draw passes.
- **Built-in Game Feel (`juice`):**
  - Trauma-based positional & camera screen shake (`shake`, `shakeCamera`)
  - Curve-driven squash & stretch animations (`squash`)
  - Hit-flash color overlays (`flash`)
- **2D Camera System (`core`):** Smooth lerp camera tracking (`setCameraFollow`), dynamic zoom (`setCameraZoom`), and integrated camera shake.
- **Collision Detection (`collision`):**
  - Separating Axis Theorem (SAT) Oriented Bounding Box (`OBB`) vs. `OBB` collisions with rotation support
  - `CircleCol` vs. `CircleCol` and `CircleCol` vs. `OBB` collisions
- **Asset Caching (`textures` & `audio`):** Automatic path-based caching for textures (`loadTexture`), sound effects (`playAudioOnce`), and looping music streams (`playAudioLoop`), with automatic cleanup on exit.
- **Immediate-Mode UI (`ui`):** Quick screen-space primitives and interactive buttons (`drawButton`) returning hover, down, and click states.
- **Clean Type Abstraction (`types` & `input`):** Self-contained `Vector2`, `Rectangle`, `Color`, `Texture`, `Key`, and `MouseButton` types decoupled from raw C bindings.

---

## Project Structure

```text
src/
├── Zest2D.nim              # Main entry / umbrella module
├── Zest2D/
│   ├── core.nim            # Game loop, window lifecycle & 2D camera
│   ├── types.nim           # Core math, color, rectangle & texture types
│   ├── math.nim            # Trigonometry, lerp, smoothstep, arch & vector helpers
│   ├── graphics.nim        # World-space shapes, outlined rects & centered texture rendering
│   ├── textures.nim        # Cached GPU texture loader & lifecycle management
│   ├── collision.nim       # Circle & rotated OBB (SAT) collision checks
│   ├── juice.nim           # Screen shake, squash & stretch, and color flash systems
│   ├── input.nim           # Keyboard & mouse input wrappers
│   ├── audio.nim           # Cached SFX & streaming music playback
│   ├── ui.nim              # Screen-space UI primitives & interactive buttons
│   ├── timer.nim           # Inline cooldown & timer utilities
│   └── helpers.nim         # Zero-overhead converters between Zest2D & Raylib types
└── examples/
    ├── demo.nim
    ├── demo2.nim
    └── demo3.nim
```

---

## Requirements & Installation

- **Nim** (`>= 2.0.0` recommended)
- **naylib** (Raylib bindings for Nim)

Install `naylib` via Nimble:

```bash
nimble install naylib
```

Clone the repository and run an example:

```bash
git clone https://github.com/islamfazliyev/Zest2D.git
cd Zest2D
nim c -r src/examples/demo3.nim
```

---

## Quick Start

Here is a complete example demonstrating movement, camera tracking, collision detection, texture rendering, and game-feel effects (`shakeCamera`, `squash`, `flash`):

```nim
import Zest2D/[core, types, input, graphics, textures, collision, juice, audio, ui]

type
  Player = object
    rect: Rectangle
    rotation: float32
    color: Color
    tex: Texture

var player = Player(
  rect: Rectangle(pos: Vector2(x: 0, y: 0), scale: Vector2(x: 48, y: 48)),
  rotation: 0.0,
  color: White
)

let obstacle = Rectangle(pos: Vector2(x: 120, y: 20), scale: Vector2(x: 64, y: 64))
var initialized = false

proc update(dt: float32) =
  if not initialized:
    player.tex = loadTexture("src/examples/test.png")
    initialized = true

  let speed = 200.0'f32
  if isKeyDown(Key.D): player.rect.pos.x += speed * dt
  if isKeyDown(Key.A): player.rect.pos.x -= speed * dt
  if isKeyDown(Key.S): player.rect.pos.y += speed * dt
  if isKeyDown(Key.W): player.rect.pos.y -= speed * dt

  # Smoothly follow the player
  setCameraFollow(player.rect.pos, smoothing = 8.0)

  # Rotated OBB collision + juice feedback
  if obbCollider(player.rect, player.rotation, obstacle, 15.0):
    if isKeyPressed(Key.Space):
      shakeCamera(8.0, 8.0, 0.25)
      squash(player.rect.scale, 14.0, -14.0, 0.25)
      flash(player.color, Red, 0.15)

proc draw() =
  drawOutlinedRectangle(obstacle, rotation = 15.0, fillColor = Blue, outlineColor = White)
  drawTexture(player.tex, player.rect, player.rotation, player.color)

proc drawUi() =
  drawText("WASD: Move | SPACE (on collision): Juice!", 20, 20, 20, White)
  if drawButton("Reset Pos", Vector2(x: 20, y: 55), Vector2(x: 130, y: 36)).isClicked:
    player.rect.pos = Vector2(x: 0, y: 0)

initCamera2D(zoom = 1.5)
initZest2D(
  screenWidth = 800,
  screenHeight = 600,
  name = "Zest2D Quick Start",
  update = update,
  draw = draw,
  drawUi = drawUi,
  backgroundClear = Black
)
```

---

## Module Overview

| Module | Responsibility |
| :--- | :--- |
| **`core`** | Main game loop, window/audio setup, 2D camera (`mainCamera`, `setCameraFollow`, `shakeCamera`) |
| **`graphics`** | World-space drawing (`drawRectangle`, `drawOutlinedRectangle`, `drawCircle`, `drawTexture`) |
| **`juice`** | `shake`, `squash`, and `flash` procedural animation effects updated automatically each frame |
| **`collision`** | `circleCollider` and SAT-based `obbCollider` supporting arbitrary rotations |
| **`textures`** | Cached `loadTexture` wrapper preventing duplicate GPU uploads |
| **`audio`** | `playAudioOnce` (cached SFX) and `playAudioLoop` (music streaming) |
| **`input`** | Clean `Key` and `MouseButton` enums with pressed/down/released/wheel queries |
| **`ui`** | Screen-space text, shapes, and stateful `drawButton` |
| **`math`** | `lerp`, `clamp`, `smoothstep`, `arch`, `overlaps`, `dot`, and angle-to-vector utilities |
| **`timer`** | Frame-rate independent `cooldown` helper |

---

## License

MIT License — feel free to use, modify, and build games with **Zest2D**.
