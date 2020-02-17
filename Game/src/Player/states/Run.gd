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
    # if not player.is_running:
    #     state_machine.change_state("Walk")
    # if player.velocity == Vector2.ZERO:
    #     state_machine.change_state("Idle")
    pass
