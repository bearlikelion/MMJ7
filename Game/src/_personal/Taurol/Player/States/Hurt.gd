extends "res://src/_personal/Taurol/StateMachine/state.gd"



func enter():
	owner.get_node("AnimationPlayer").play("Hurt")

func _on_animation_finished(anim_name):
	emit_signal("finished", "runSlow")
