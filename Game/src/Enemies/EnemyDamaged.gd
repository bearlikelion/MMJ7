extends "res://src/StateMachine/state.gd"

var timer = 0.3
var plrDir

func enter():
	timer = 0.3
	owner.data.hp -= 1
	if owner.data.hp <= 0:
		emit_signal("finished","death")
		owner.data.state = "dead"
	
func exit():
	pass

func update(delta):
	if timer > 0:
		timer -= delta*1
		var playerGroup = get_tree().get_nodes_in_group("player")
		for i in playerGroup:
			plrDir = i.data.dir
		var pushTo = Vector2.ZERO
		if plrDir == "left":
			pushTo = Vector2(-1,0)
		elif plrDir == "right":
			pushTo = Vector2(1,0)
		elif plrDir == "up":
			pushTo = Vector2(0,-1)
		elif plrDir == "down":
			pushTo = Vector2(0,1)
		owner.velocity = pushTo * (owner.speed*3) * (timer/0.3)
	else:
		emit_signal("finished","idle")