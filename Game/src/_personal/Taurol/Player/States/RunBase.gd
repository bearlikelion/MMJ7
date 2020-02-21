extends "res://src/_personal/Taurol/Player/States/motion.gd"


export var MAX_SPEED :=300
export var MIN_SPEED :=0
export var JOGGING_ACCELERATION := 2000
export var JOGGING_DECCELERATION:= 1000
export var RUNNING_ACCELERATION := 2000
export var RUNNING_DECCELERATION:= 1000



func enter():
	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	#owner.get_node("AnimationPlayer").play("walk")


func update(delta):
	
	var accel:=0
	var deccel:=0
	var input_direction = get_input_direction()
	if not input_direction:
		if owner.motion==Vector2.ZERO:
			emit_signal("finished", "idle")
	
	if Input.is_action_pressed("sprint"):
		accel=RUNNING_ACCELERATION
		deccel=RUNNING_DECCELERATION
	if !Input.is_action_pressed("sprint"):
		accel=JOGGING_ACCELERATION
		deccel=JOGGING_DECCELERATION
	
	move(input_direction.normalized(),accel,deccel,delta)


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

