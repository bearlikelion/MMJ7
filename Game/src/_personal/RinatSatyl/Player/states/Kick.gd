extends Node

export (float) var run_multiplier = 1.5

onready var state_machine = get_parent()
onready var player = state_machine.get_parent()
onready var kick = player.get_node("AttacksBlock").get_node("kick")
onready var kickSpeed = player.kickSpeed
onready var speedEntered = player.speed

func enter():
	if state_machine.previous_state.name == "Walk":
		speedEntered = speedEntered
	elif state_machine.previous_state.name == "Run":
		speedEntered = speedEntered
	if kickSpeed == player.kickSpeed:
    	kick.get_node(player.dir).get_node("CollisionShape2D").disabled = false

func exit():
	kick.get_node("left").get_node("CollisionShape2D").disabled = true
	kick.get_node("right").get_node("CollisionShape2D").disabled = true
	kick.get_node("up").get_node("CollisionShape2D").disabled = true
	kick.get_node("down").get_node("CollisionShape2D").disabled = true
    

func update(_delta):
	player.velocity = player.velocity.normalized() * speedEntered
	if kickSpeed > 0:
    	kickSpeed -= _delta*1
	else:
		kickSpeed = player.kickSpeed
		state_machine.change_state("Idle")
