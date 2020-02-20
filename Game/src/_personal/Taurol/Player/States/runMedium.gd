extends "res://src/_personal/Taurol/Player/States/RunBase.gd"


var offset:int=5


func update(delta):
	if owner.motion.length()>=MAX_SPEED+offset:
		emit_signal("finished","runFast")
	if owner.motion.length()<=MIN_SPEED:
		emit_signal("finished","runSlow")
	.update(delta)

func apply_movement(accel):
	owner.motion+=accel
	owner.motion=owner.motion.clamped(MAX_SPEED)
