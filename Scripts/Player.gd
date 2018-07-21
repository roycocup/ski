extends KinematicBody2D

export (int) var speed = 100
onready var pos = Vector2()



func _physics_process(delta):
	input_listen(delta)
	move_and_slide(pos)


func input_listen(delta):
	pos = Vector2()
	if Input.is_key_pressed(KEY_RIGHT):
		pos = Vector2(speed, 0)
	if Input.is_key_pressed(KEY_LEFT):
		pos = Vector2(-speed, 0)
	if Input.is_key_pressed(KEY_UP):
		pos = Vector2(0, 0)
	if Input.is_key_pressed(KEY_DOWN):
		pos = Vector2(0, speed)