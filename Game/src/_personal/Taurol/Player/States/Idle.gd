extends "res://src/_personal/Taurol/Player/States/motion.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func enter():
	pass
	#owner.get_node("AnimationPlayer").play("idle")


func update(delta):
	var input_direction = get_input_direction()
	if input_direction:
		emit_signal("finished", "move")
