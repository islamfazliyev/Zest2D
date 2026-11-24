import raylib
import types
import helpers
import std/tables

var textures*: Table[string, types.Texture]

proc loadTexture*(path: string): types.Texture =
  if path notin textures:
    var rlTex = raylib.loadTexture(path)
    textures[path] = types.Texture(
      id: rlTex.id,
      width: rlTex.width,
      height: rlTex.height,
      mipmaps: rlTex.mipmaps,
      format: int32(rlTex.format)
    )
    wasMoved(rlTex)
  return textures[path]

proc clear*() =
    textures.clear