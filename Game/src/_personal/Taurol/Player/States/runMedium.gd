extends "res://src/_personal/Taurol/Player/States/RunBase.gd"


export var JOGGING_COUNTER_ACCELERATION :=0

var offset:int=5
var del:=0.0


func update(delta):
	if owner.motion.length()>=MAX_SPEED+offset:
		emit_signal("finished","runFast")
		return
	if owner.motion.length()<=MIN_SPEED:
		emit_signal("finished","runSlow")
		return
	del=delta
	.update(delta)


func apply_movement(accel):
	if !Input.is_action_pressed("action_run"):
		apply_friction(JOGGING_COUNTER_ACCELERATION*del)
	.apply_movement(accel)
