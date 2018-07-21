extends RigidBody2D

export (int) var speed = 100
onready var pos = Vector2()
var region = {x=0, y=0, w=0, h=0}
enum statuses {RESET, LEFT1, LEFT2, RIGHT1, RIGHT2}
var status = statuses.RESET

signal reset_background


func _ready():
	animate_reset()
	linear_velocity.y = speed


func _physics_process(delta):
	input_listen(delta)
	check_reset_background()
	

func input_listen(delta):
	pos = Vector2()
	if Input.is_action_just_pressed("ui_right"):
		linear_velocity = Vector2(speed * .75, speed * .75)
		animate_turn_45()
	if Input.is_key_pressed(KEY_LEFT):
		linear_velocity = Vector2(-speed * .75, speed * .75)
		animate_turn_45(true)
	if Input.is_key_pressed(KEY_DOWN):
		linear_velocity = Vector2(0, speed)
		animate_reset()

func animate_reset():
	region = {x=35, y=10, w=49, h=97} 
	$Sprite.region_rect.position = Vector2(region.x, region.y)
	$Sprite.region_rect.size = Vector2(region.w, region.h)

func animate_turn_45(mirror = false):
	region = {x=158, y=10, w=60, h=100} 
	$Sprite.region_rect.position = Vector2(region.x, region.y)
	$Sprite.region_rect.size = Vector2(region.w, region.h)
	if (mirror):
		$Sprite.scale.x = -.5
	else:
		$Sprite.scale.x = .5

func animate_turn_90(mirror = false):
	region = {x=276, y=11, w=83, h=74} 
	$Sprite.region_rect.position = Vector2(region.x, region.y)
	$Sprite.region_rect.size = Vector2(region.w, region.h)
	if (mirror):
		$Sprite.scale.x = -.5
	else:
		$Sprite.scale.x = .5

func check_reset_background():
	var x = fmod(position.y, 512)
	if (x > 0 and x < 1):
		emit_signal("reset_background")