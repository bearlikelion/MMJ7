extends "res://src/_personal/Taurol/Player/States/RunBase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func update(delta):
	if owner.motion.length()>MAX_SPEED:
		emit_signal("finished","runMedium")
		
	.update(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
