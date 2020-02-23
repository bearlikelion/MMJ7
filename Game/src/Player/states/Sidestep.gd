extends Node

onready var state_machine = get_parent()
onready var player = state_machine.get_parent()

onready var last_velocity = player.velocity

func enter():
	player.velocity = calc_force_sidestep()
	state_machine.get_node("sidestep_timer").start()
	pass

func exit():
	pass

func update(delta):
	pass

func calc_force_sidestep(multiplier = 1):
	#calculates vector2 that represents the force from the starting phase of a sidestep
	return player.input_axes * player.FORCE_SIDESTEP * multiplier
