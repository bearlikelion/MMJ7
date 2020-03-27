extends "res://src/Player/States/motion.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func enter():
	if owner.data.dir == "left":
		owner.get_node("AnimationPlayer").play("Idle_Left")
	elif owner.data.dir == "right":
		owner.get_node("AnimationPlayer").play("Idle_Right")
	elif owner.data.dir == "up":
		owner.get_node("AnimationPlayer").play("Idle_Up")
	elif owner.data.dir == "down":
		owner.get_node("AnimationPlayer").play("Idle_Down")


func update(delta):
	var input_direction = get_input_direction()
	if input_direction!=Vector2.ZERO:
		emit_signal("finished", "runSlow")
