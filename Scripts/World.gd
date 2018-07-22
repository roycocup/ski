extends Node2D

export (PackedScene) var background

var hud

onready var cam1 = $Player/Camera2D
onready var cam2 = $SeeAllCamera

func _ready():
	cam1.make_current()
	set_process(true)

func _process(delta):
	quit_button()
	$Player/Camera2D/Player_Speed.text = String(round($Player.linear_velocity.y))
	camera_switch()
	
func quit_button():
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func camera_switch():
	if Input.is_key_pressed(KEY_1):
		cam1.make_current()
	if Input.is_key_pressed(KEY_2):
		cam2.make_current()
	

func _on_Player_create_new_background(player_pos):
	print("creating new background")
	var offset = 256
	var bck = background.instance()
	$Backgrounds.add_child(bck)
	bck.position = Vector2(0, player_pos.y + offset)
