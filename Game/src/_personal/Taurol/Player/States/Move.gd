extends "res://src/_personal/Taurol/Player/States/motion.gd"

const MAX_SPEED :=300
const ACCELERATION := 2000

var speed:=0.0
var motion := Vector2.ZERO


func enter():
	speed = 0.0
	motion=Vector2.ZERO
	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	#owner.get_node("AnimationPlayer").play("walk")


func update(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		if speed==0:
			emit_signal("finished", "idle")
	
	if input_direction==Vector2.ZERO:
		apply_friction(ACCELERATION*delta)
	else:
		apply_movement(input_direction*ACCELERATION*delta)
	
	update_look_direction(input_direction)
	
	motion=owner.move_and_slide(motion)


func apply_friction(amount):
	if motion.length()>amount:
		motion-=motion.normalized()*amount
	else:
		motion=Vector2.ZERO


func apply_movement(accel):
	motion+=accel
	motion=motion.clamped(MAX_SPEED)
