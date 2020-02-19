extends "res://src/_personal/Taurol/Player/States/motion.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func enter():
	#print("Idle")
	#print(owner.motion)
	#owner.get_node("AnimationPlayer").play("idle")
	pass


func update(delta):
	var input_direction = get_input_direction()
	if input_direction!=Vector2.ZERO:
		emit_signal("finished", "walk")
