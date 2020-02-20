extends "res://src/_personal/Taurol/Player/States/motion.gd"

export var MAX_SPEED :=300
export var ACCELERATION := 2000
export var DECCELERATION:= 1000


func enter():
	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	#owner.get_node("AnimationPlayer").play("walk")


func update(delta):
	if Input.is_action_pressed("sprint"):
		emit_signal("finished","sprint")
	var input_direction = get_input_direction()
	if not input_direction:
		if owner.motion==Vector2.ZERO:
			emit_signal("finished", "idle")
	
	move(input_direction,delta)


func move(input_direction,delta):
	if input_direction==Vector2.ZERO:
		apply_friction(DECCELERATION*delta)
	else:
		apply_movement(input_direction*ACCELERATION*delta)
	
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
