extends "res://src/StateMachine/state.gd"

func enter():
	owner.get_node("AnimationPlayer").play("Dead")
	owner.velocity = Vector2.ZERO