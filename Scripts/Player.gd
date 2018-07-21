extends RigidBody2D

export (int) var speed = 100
var region = {x=0, y=0, w=0, h=0}
enum statuses {RESET, LEFT1, LEFT2, RIGHT1, RIGHT2}
var status = statuses.RESET
signal reset_background

var FSM = preload("FSM.gd")

func _ready():
	animate_reset()
	linear_velocity.y = speed


func _physics_process(delta):
	input_listen(delta)
	check_reset_background()
	
	
func input_listen(delta):
	if Input.is_action_just_pressed("ui_right"):
		if status == statuses.RIGHT1:
			status = statuses.RIGHT2
			region = {x=276, y=11, w=83, h=74} 
			linear_damp = .5
		else:
			status = statuses.RIGHT1
			region = {x=158, y=10, w=60, h=100}
			linear_damp = .1
		linear_velocity = Vector2(speed * .75, speed * .75)
		set_animate_region()
	if Input.is_key_pressed(KEY_LEFT):
		if status == statuses.LEFT1:
			status = statuses.LEFT2
			region = {x=276, y=11, w=83, h=74}
		else: 
			status = statuses.LEFT1 
			region = {x=158, y=10, w=60, h=100} 
		linear_velocity = Vector2(-speed * .75, speed * .75)
		set_animate_region(true)
	if Input.is_key_pressed(KEY_DOWN):
		status = statuses.RESET 
		linear_velocity = Vector2(0, speed)
		animate_reset()

func animate_reset():
	region = {x=35, y=10, w=49, h=97} 
	$Sprite.region_rect.position = Vector2(region.x, region.y)
	$Sprite.region_rect.size = Vector2(region.w, region.h)
	linear_damp = -1
	toggle_direction()
	
func set_animate_region(mirror = false):
	$Sprite.region_rect.position = Vector2(region.x, region.y)
	$Sprite.region_rect.size = Vector2(region.w, region.h)
	toggle_direction(mirror)

func toggle_direction(mirror = false):
	if (mirror):
		$Sprite.scale.x = -.5
	else:
		$Sprite.scale.x = .5

func check_reset_background():
	var x = fmod(position.y, 512)
	if (x > 0 and x < 1):
		emit_signal("reset_background")