extends "res://src/_personal/Taurol/Player/States/RunBase.gd"


export var JOGGING_COUNTER_ACCELERATION :=0

var del:=0.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func update(delta):
	if owner.motion.length()<=MIN_SPEED:
		emit_signal("finished","runMedium")
	del=delta
	.update(delta)


func apply_movement(accel):
	if !Input.is_action_pressed("sprint"):
		apply_friction(JOGGING_COUNTER_ACCELERATION*del)
	.apply_movement(accel)
