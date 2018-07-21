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
	#background_follow()
	
func quit_button():
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

#func background_follow():
#	var bottom = get_viewport_rect().size.y
#	var cam_bottom = $Player/Camera2D.position.y
	