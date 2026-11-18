import raylib
import std/tables

var sounds*: Table[string, Sound]
var currentMusic: Music
var hasMusic = false

proc playAudioOnce*(path: string) =
  if path notin sounds:
    sounds[path] = loadSound(path)
  
  raylib.playSound(sounds[path])

proc playAudioLoop*(path: string) =
  currentMusic = loadMusicStream(path)
  currentMusic.looping = true
  raylib.playMusicStream(currentMusic)
  hasMusic = true

proc updateAudio*() =
  if hasMusic:
    updateMusicStream(currentMusic)

proc clear*() =
    sounds.clear