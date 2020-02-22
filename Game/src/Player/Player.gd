extends KinematicBody2D

export (int) var speed = 200

var velocity := Vector2.ZERO
var input_axes := Vector2.ZERO
var is_running := false
var queued_action
export var isLoaded = false
var data = {
	"pos_x": position.x,
	"pos_y": position.y,
	}


func _ready() -> void:
    add_to_group("player")
    $States.start()
    pass

func _physics_process(_delta) -> void:
    get_input()
    handle_states()
    velocity = move_and_slide(velocity)

func get_input() -> void:
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

	# Normalize so diagonal movement isn't faster
	velocity = velocity.normalized() * speed


func handle_states() -> void:
	if Input.is_action_pressed("action_run") && $States.current_state.name != "Run":
		$States.change_state("Run")
	elif Input.is_action_just_released("action_run") && velocity != Vector2.ZERO:
		$States.change_state("Walk")
	elif Input.is_action_just_released("action_run") && velocity == Vector2.ZERO:
		$States.change_state("Idle")

func _on_states_state_changed(state) -> void:
	print("[Player State] " + state)

func save():
	var oPos = get_position()
	var toSave = {
		"name":	self.name,
		"pos_x": oPos.x,
		"pos_y": oPos.y,
	}
	return toSave

func load(rData):
	data = rData
	position.x = data.pos_x
	position.y = data.pos_y

