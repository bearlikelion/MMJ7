extends "res://src/StateMachine/state.gd"

func enter():
	owner.get_node("AgroRadius").get_node("CollisionShape2D").scale = Vector2(3, 3)
	
func exit():
	owner.get_node("AgroRadius").get_node("CollisionShape2D").scale = Vector2(1 ,1)

func update(delta):
	owner.velocity = Vector2.ZERO
	if owner.player:
		owner.velocity = owner.position.direction_to(owner.player.position) * owner.speed
	else:
		emit_signal("finished","idle")
