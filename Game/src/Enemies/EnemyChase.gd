extends "res://src/_personal/Taurol/StateMachine/state.gd"

func enter():
	pass
	
func exit():
	pass

func update(delta):
	owner.velocity = Vector2.ZERO
	if owner.player:
		owner.velocity = owner.position.direction_to(owner.player.position) * owner.speed
	else:
		emit_signal("finished","idle")
