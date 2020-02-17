extends Node

onready var state_machine = get_parent()
onready var player = state_machine.get_parent()

func enter():
	pass

func exit():
	pass

func update(delta):
	if player.is_running:
		state_machine.change_state("Run")
	if player.velocity == Vector2.ZERO:
		state_machine.change_state("Idle")
	pass
