extends Panel

onready var log_view := $LogView

func _ready():
	Logger.connect("log_emitted", self, "_on_log_emitted")
	log_view.clear()
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("clear_log"):
		_clear_log_ui()

func _on_log_emitted(level: int, line: String):
	var colored := _colorize(level, line)
	log_view.append_bbcode(colored)

func _clear_log_ui():
	log_view.clear()
	Logger.info("Log UI cleared (F2)")

func _colorize(level: int, line: String) -> String:
	match level:
		Logger.LogLevel.DEBUG:
			return "[color=gray]%s[/color]" % line
		Logger.LogLevel.INFO:
			return "[color=white]%s[/color]" % line
		Logger.LogLevel.WARN:
			return "[color=yellow]%s[/color]" % line
		Logger.LogLevel.ERROR:
			return "[color=red]%s[/color]" % line
		Logger.LogLevel.FATAL:
			return "[color=orange][b]%s[/b][/color]" % line
		_:
			return line
