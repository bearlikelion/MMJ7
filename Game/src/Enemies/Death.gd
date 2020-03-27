extends "res://src/StateMachine/state.gd"

var timer = 0
var pushTimer = 0.2
var plrDir

func enter():
	timer = 1
	owner.get_node("AnimationPlayer").play("Death")

func update(delta):
	if pushTimer > 0:
		pushTimer -= 1*delta
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
		owner.velocity = pushTo * (owner.speed*3) * (timer/1)
	else:
		owner.velocity = Vector2.ZERO
	if timer > 0:
		timer -= 1*delta
	else:
		emit_signal("finished","dead")