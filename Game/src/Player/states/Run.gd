extends Node

onready var state_machine = get_parent()
onready var player = state_machine.get_parent()

func enter():
	player.speed *= 2
	pass

func exit():
	player.speed /= 2
	pass

func update(delta):
	if not player.is_running:
		state_machine.change_state("Walk")
	if player.velocity == Vector2.ZERO:
		state_machine.change_state("Idle")
	pass
