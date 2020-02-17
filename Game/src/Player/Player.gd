extends KinematicBody2D

export (int) var speed = 200

var velocity := Vector2.ZERO
var input_axes := Vector2.ZERO
var is_running := false
var queued_action

func _ready():
	$states.start()
	pass

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

func get_input():
	velocity = Vector2.ZERO
	
	input_axes.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input_axes.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	input_axes = (input_axes.normalized()).clamped(1)
	
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('right'):
		velocity.x += 1
	
	if Input.is_action_pressed("action_run"):
		is_running = true
	else:
		is_running = false
	
	# Normalize so diagonal movement isn't faster
	velocity = velocity.normalized() * speed


func _on_states_state_changed(state):
	print(state)
	pass # Replace with function body.
