extends "res://src/_personal/Taurol/Player/States/RunBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func update(delta):
	if owner.motion.length()<=MIN_SPEED:
		emit_signal("finished","runSlow")
	.update(delta)

func apply_movement(accel):
	owner.motion+=accel
	owner.motion=owner.motion.clamped(MAX_SPEED)
