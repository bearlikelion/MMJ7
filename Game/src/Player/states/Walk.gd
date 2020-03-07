extends Node

onready var state_machine = get_parent()
onready var player = state_machine.get_parent()

func enter():
	pass

func exit():
	pass

func update(_delta):
	player.velocity = Vector2.ZERO

	if Input.is_action_pressed('up'):
		player.velocity.y -= 1
		player.dir = "up"
	if Input.is_action_pressed('down'):
		player.velocity.y += 1
		player.dir = "down"
	if Input.is_action_pressed('left'):
		player.velocity.x -= 1
		player.dir = "left"
	if Input.is_action_pressed('right'):
		player.velocity.x += 1
		player.dir = "right"
		
	if player.velocity == Vector2.ZERO:
		state_machine.change_state("Idle")
		
	# Normalize so diagonal movement isn't faster
	player.velocity = player.velocity.normalized() * player.speed

