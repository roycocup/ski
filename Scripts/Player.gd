extends RigidBody2D

export (int) var speed = 100
var region = {x=0, y=0, w=0, h=0}
var howFarDown = 0
var lastMark = 0
onready var FSM = preload("res://Scripts/FSM.gd").new()

signal create_new_background


func _ready():
	init_states()
	animate_reset()
	linear_velocity.y = speed

func _physics_process(delta):
	input_listen(delta)
	animate()
	check_reset_background()
	
func init_states():
	FSM.add_state(
		FSM.states.RESET, [
			{"event":FSM.events.LEFT, "state":FSM.states.LEFT1}, 
			{"event":FSM.events.RIGHT, "state":FSM.states.RIGHT1}, 
		])
	# FSM.add_state(FSM.states.LEFT1, [FSM.states.LEFT2, FSM.states.RESET])
	# FSM.add_state(FSM.states.LEFT2, [FSM.states.LEFT1])
	# FSM.add_state(FSM.states.RIGHT1, [FSM.states.RIGHT2, FSM.states.RESET])
	# FSM.add_state(FSM.states.RIGHT2, [FSM.states.RIGHT1])
	FSM.current_state = FSM.states.RESET

func input_listen(delta):
	if Input.is_action_just_pressed("ui_right"):
		FSM.handle(FSM.events.RIGHT)
	if Input.is_action_just_pressed("ui_left"):
		FSM.handle(FSM.events.LEFT)

func animate():
	if FSM.current_state == FSM.states.RESET:
		linear_velocity = Vector2(0, speed)
		animate_reset()
		return
	if FSM.current_state == FSM.states.RIGHT1:
		region = {x=158, y=10, w=60, h=100}
		linear_damp = .1
	if FSM.current_state == FSM.states.RIGHT2:
		region = {x=276, y=11, w=83, h=74} 
		linear_damp = .5
	if FSM.current_state == FSM.states.LEFT1:
		region = {x=158, y=10, w=60, h=100} 
		linear_damp = .1
	if FSM.current_state == FSM.states.LEFT2:
		region = {x=276, y=11, w=83, h=74}
		linear_damp = .5
	
	linear_velocity = Vector2(-speed * .75, speed * .75)
	set_animate_region(true)

# func input_listen_old(delta):
# 	if Input.is_action_just_pressed("ui_right"):
# 		if status == States.RIGHT1:
# 			status = States.RIGHT2
# 			region = {x=276, y=11, w=83, h=74} 
# 			linear_damp = .5
# 		else:
# 			status = States.RIGHT1
# 			region = {x=158, y=10, w=60, h=100}
# 			linear_damp = .1
# 		linear_velocity = Vector2(speed * .75, speed * .75)
# 		set_animate_region()
# 	if Input.is_action_just_pressed("ui_left"):
# 		if status == States.LEFT1:
# 			status = States.LEFT2
# 			region = {x=276, y=11, w=83, h=74}
# 			linear_damp = .5
# 		else: 
# 			status = States.LEFT1 
# 			region = {x=158, y=10, w=60, h=100} 
# 			linear_damp = .1
# 		linear_velocity = Vector2(-speed * .75, speed * .75)
# 		set_animate_region(true)
# 	if Input.is_key_pressed(KEY_DOWN):
# 		status = States.RESET 
# 		linear_velocity = Vector2(0, speed)
# 		animate_reset()

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
	if (position.y >= lastMark + 512):
		lastMark = position.y
		emit_signal("create_new_background", position)

	