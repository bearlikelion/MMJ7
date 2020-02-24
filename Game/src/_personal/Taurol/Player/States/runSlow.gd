extends "res://src/_personal/Taurol/Player/States/RunBase.gd"


var offset:int=5


func update(delta):
	if owner.motion.length()>MAX_SPEED+offset:
		emit_signal("finished","runMedium")
		
	#print(owner.motion)
	.update(delta)


func apply_movement(accel):
	if Input.is_action_pressed("sprint"):
		owner.motion+=accel
	else:
		.apply_movement(accel)

