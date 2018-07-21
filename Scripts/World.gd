extends Node2D

var cur_camera
var cur_background
var bottom_background

func _ready():
	$Player/Camera2D.make_current()
	cur_background = $Bck
	bottom_background = $Bck_bot
	set_process(true)

func _process(delta):
	quit_button()
	background_follow()
	
func quit_button():
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func background_follow():
	#var bottom_line = $Player/Camera2D.get_viewport()
	#var last_visible_line_pos = $Bck_bot.position.y + $Bck_bot.transform.origin.y
	pass
	