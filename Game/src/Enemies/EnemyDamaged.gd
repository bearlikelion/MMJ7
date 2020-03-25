extends "res://src/StateMachine/state.gd"

var timer = 0.3
var playerPos = Vector2.ZERO

func enter():
	timer = 0.3
	owner.data.hp -= 1
	
func exit():
	pass

func update(delta):
	if timer > 0:
		timer -= delta*1
		if owner.player:
			playerPos = owner.player.position
		owner.velocity = playerPos.direction_to(owner.position) * owner.speed*2
	else:
		emit_signal("finished","idle")