extends Node
signal log_emitted(level, line)
const LOG_DIR := "res://logs/"

# Log levels
enum LogLevel {
	DEBUG,
	INFO,
	WARN,
	ERROR,
	FATAL
}

# =========================
# Config
# =========================
var min_level = LogLevel.INFO
var log_file_path := ""

# =========================
# Lifecycle
# =========================
func _ready():
	_ensure_log_dir()
	_create_session_log_file()
	info("Logger session started")

# =========================
# Public API
# =========================
func debug(message: String, node_name := ""):
	_log(LogLevel.DEBUG, message, node_name)

func info(message: String, node_name := ""):
	_log(LogLevel.INFO, message, node_name)

func warn(message: String, node_name := ""):
	_log(LogLevel.WARN, message, node_name)

func error(message: String, node_name := ""):
	_log(LogLevel.ERROR, message, node_name)

# =========================
# Core
# =========================
func _log(level: int, message: String, node_name := ""):
	if level < min_level:
		return

	var time := _timestamp()
	var level_str := _level_to_string(level)

	var line := "[%s] [%s] %s" % [time, level_str, message]

	if node_name != "":
		line += " (Node: %s)" % node_name

	line += "\n"
	_append(line)
	emit_signal("log_emitted", level, line)

func fatal(message: String, node_name := "", quit := false):
	_log(LogLevel.FATAL, message, node_name)

	# kasih tahu engine juga
	push_error("FATAL: " + message)

	if quit:
		get_tree().quit(1)

# =========================
# Internal
# =========================
func _create_session_log_file():
	var session_time := _timestamp_file()
	var file_name := "log_%s.txt" % session_time
	log_file_path = LOG_DIR + file_name

	var file := File.new()
	file.open(log_file_path, File.WRITE_READ)
	file.close()

func _ensure_log_dir():
	var dir := Directory.new()
	if not dir.dir_exists(LOG_DIR):
		dir.make_dir_recursive(LOG_DIR)

func _append(text: String):
	var file := File.new()
	var err := file.open(log_file_path, File.READ_WRITE)
	if err != OK:
		push_error("Logger: Cannot open log file")
		return

	file.seek_end()
	file.store_string(text)
	file.close()

func _timestamp() -> String:
	var t := OS.get_datetime()
	return "%04d-%02d-%02d %02d:%02d:%02d" % [
		t.year, t.month, t.day,
		t.hour, t.minute, t.second
	]

func _timestamp_file() -> String:
	var t := OS.get_datetime()
	return "%04d-%02d-%02d_%02d-%02d-%02d" % [
		t.year, t.month, t.day,
		t.hour, t.minute, t.second
	]

func _level_to_string(level: int) -> String:
	match level:
		LogLevel.DEBUG:
			return "DEBUG"
		LogLevel.INFO:
			return "INFO"
		LogLevel.WARN:
			return "WARN"
		LogLevel.ERROR:
			return "ERROR"
		LogLevel.FATAL:
			return "FATAL"
		_:
			return "UNKNOWN"
