extends Control

onready var log_panel := $LogPanel

func toggle_log():
	log_panel.visible = true
	log_panel.modulate.a = 0
	
	$LogPanel/Tween.interpolate_property(
		log_panel, "modulate:a",
		0, 1, 0.15,
		Tween.TRANS_SINE, Tween.EASE_OUT
	)
	$LogPanel/Tween.start()


func _ready():
	log_panel.visible = false # atau false, bebas

func _input(event):
	if event.is_action_pressed("toggle_log"):
		log_panel.visible = !log_panel.visible


func _on_Button_pressed():
	pass # Replace with function body.
