extends "res://src/StateMachine/state.gd"

var timer = 0
var timerForJump = 0
var playerPos = Vector2.ZERO

func enter():
	timer = 1.5
	timerForJump = 0.3
	owner.get_node("AgroRadius").get_node("CollisionShape2D").disabled = true
	
func exit():
	owner.get_node("AgroRadius").get_node("CollisionShape2D").disabled = false

func update(delta):
	if timer > 0:
		timer -= delta*1
		var playerGroup = get_tree().get_nodes_in_group("player")
		for i in playerGroup:
			playerPos= i.position
		if timerForJump > 0:
			timerForJump -= delta*1
			owner.velocity = playerPos.direction_to(owner.position) * owner.speed*1
		else:
			owner.velocity = Vector2.ZERO
	else:
		emit_signal("finished","idle")