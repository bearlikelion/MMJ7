extends "res://src/_personal/Taurol/Player/States/motion.gd"

export var MAX_SPEED :=300


func enter():
	var input_direction = get_input_direction()
	update_look_direction(input_direction)


func move(input_direction,accel,deccel,delta):
	if input_direction==Vector2.ZERO:
		apply_friction(deccel*delta)
	else:
		apply_movement(input_direction*accel*delta)
	
	update_look_direction(input_direction)
	
	owner.motion=owner.move_and_slide(owner.motion)


func apply_friction(amount):
	if owner.motion.length()>amount:
		owner.motion-=owner.motion.normalized()*amount
	else:
		owner.motion=Vector2.ZERO


func apply_movement(accel):
		owner.motion+=accel
		owner.motion=owner.motion.clamped(MAX_SPEED)
