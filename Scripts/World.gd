extends Node2D

var cur_camera
var cur_background_y
var bottom_background_y

var hud

func _ready():
	$Player/Camera2D.make_current()
	cur_background_y = $Bck.position.y
	bottom_background_y = $Bck_bot.position.y
	set_process(true)

func _process(delta):
	quit_button()
	$Player/Camera2D/Player_Speed.text = String(round($Player.linear_velocity.y))
	background_follow()
	
func quit_button():
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func background_follow():
	#var bottom_line = $Player/Camera2D.get_viewport()
	#var last_visible_line_pos = $Bck_bot.position.y + $Bck_bot.transform.origin.y
	pass
	

func _on_Player_reset_background():
	print("reset backgrounds")
	$Bck.position.y += 512
	$Bck_bot.position.y += 512
