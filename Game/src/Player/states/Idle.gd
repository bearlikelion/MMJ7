extends Node

onready var state_machine = get_parent()
onready var player = state_machine.get_parent()

func enter():
	player.velocity = Vector2.ZERO
	player.velocity = player.velocity.normalized() * player.speed

func exit():
	pass

func update(_delta):
	# if player.velocity != Vector2.ZERO:
	# 	if player.is_running:
	# 		state_machine.change_state("Run")
	# 	else:
	# 		state_machine.change_state("Walk")
	pass
