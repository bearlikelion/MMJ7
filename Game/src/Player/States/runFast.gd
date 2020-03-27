extends "res://src/Player/States/RunBase.gd"


export var JOGGING_COUNTER_ACCELERATION :=0

var del:=0.0

func enter():
	owner.get_node("AnimationPlayer").set_speed_scale(1.3)

func update(delta):
	if owner.motion.length()<=MIN_SPEED:
		emit_signal("finished","runMedium")
		return
	del=delta
	.update(delta)


func apply_movement(accel):
	apply_friction(JOGGING_COUNTER_ACCELERATION*del)
	.apply_movement(accel)
