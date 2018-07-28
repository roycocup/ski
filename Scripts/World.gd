extends Node2D

export (PackedScene) var background
export (PackedScene) var rock

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
	var offset = 512
	var back = background.instance()
	# get the last element from the backgrounds
	var last_back = $Backgrounds.get_children().pop_back()
	# add the child to backgrounds as last
	$Backgrounds.add_child_below_node(last_back, back)
	# position it as right after last by the size of the background
	back.position = Vector2(0, last_back.position.y + offset)
	
