# Universal Logger — Godot 3.6
I Vibecoded this entire thing with chatGPT 5.2 and it's surprisingly works, i just had to minor debug it, so i declare that following codes in here are NOT MINE.

Oh yeah this repo included the premade ui for live logging in-runtime so yea have fun, if you just wanna use core logger backend, import Logger.gd to your project!
you should be able to easily implement your own custom ui if you want.

Session-based, level-based logger for Godot 3.5–3.6.
Designed for tools and applications.

---

## Features

- Log levels: `DEBUG`, `INFO`, `WARN`, `ERROR`, `FATAL`
- One log file per application run
- Append-only (no overwrite)
- Autoload singleton
- Optional live log UI via signal

---

## Install

1. Copy `Logger.gd`
2. Add as AutoLoad:
   - Name: `Logger`
   - Path: `res://Logger.gd`
3. Restart editor

---

## Usage

```gdscript
Logger.debug("Parsing chunk")
Logger.info("Start conversion")
Logger.warn("Missing texture")
Logger.error("Export failed")
Logger.fatal("Critical error", "", true)
```
```gdscript
func _on_button_pressed():
   Logger.info("Button pressed")
```
-Output will be:
```
[YYYY-MM-DD HH:MM:SS] [INFO] Button pressed 
```


## Log Format
```raw text
[YYYY-MM-DD HH:MM:SS] [LEVEL] Message (Node: NodeName)

```
## Notes
-Logs stored in `res://logs/` (use `user://logs/` for exports)
-Logger does not handle input or UI
-Suitable for reuse across projects

## Compatibility
Godot 3.5–3.6 
