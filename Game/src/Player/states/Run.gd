extends Node

export (float) var run_multiplier = 1.5

onready var state_machine = get_parent()
onready var player = state_machine.get_parent()

func enter():
    player.speed *= run_multiplier
    pass

func exit():
    player.speed /= run_multiplier
    pass

func update(_delta):
    state_machine.get_node("Walk").update(_delta)
