extends "res://src/StateMachine/state.gd"

var velMem = Vector2.ZERO

func enter():
	owner.get_node("AgroRadius").get_node("CollisionShape2D").scale = Vector2(3, 3)
	
func exit():
	owner.get_node("AgroRadius").get_node("CollisionShape2D").scale = Vector2(1 ,1)
	if velMem.y < 0:
		owner.get_node("AnimationPlayer").play("Idle_Down")
	else:
		owner.get_node("AnimationPlayer").play("Idle_Up")
	if velMem.x < 0.4:
		owner.get_node("AnimationPlayer").play("Idle_Left")
	else:
		owner.get_node("AnimationPlayer").play("Idle_Right")

func update(delta):
	owner.velocity = Vector2.ZERO
	if owner.player:
		owner.velocity = owner.position.direction_to(owner.player.position) * owner.speed
		velMem = owner.velocity
		if owner.velocity.y < 0.2:
			owner.get_node("AnimationPlayer").play("Run_Down")
		elif owner.velocity.y > 0.2:
			owner.get_node("AnimationPlayer").play("Run_Up")
		elif owner.velocity.x < 0.4:
			owner.get_node("AnimationPlayer").play("Run_Left")
		elif owner.velocity.x > 0.4:
			owner.get_node("AnimationPlayer").play("Run_Right")
	else:
		emit_signal("finished","idle")
