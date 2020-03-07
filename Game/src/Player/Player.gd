extends KinematicBody2D

export (int) var speed = 200
export var dir = "left"
export var kickSpeed = 0.1
export var isLoaded = false

var velocity := Vector2.ZERO
var input_axes := Vector2.ZERO
var is_running := false
var queued_action
var data = {
	"pos_x": position.x,
	"pos_y": position.y,
	"hp": 10,
	"maxHp": 10,
	"kickSpeed": 0.1,
	}


func _ready() -> void:
	$States.start()
	Fmod.system_add_listener(self)
	pass

func _physics_process(_delta) -> void:
	add_to_group("player")
	handle_states()
	velocity = move_and_slide(velocity)
	$Debug.get_node("Label").text = dir
	$Debug.get_node("Label2").text = $States.current_state.name
	
	input_axes.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input_axes.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	input_axes = (input_axes.normalized()).clamped(1)
	

func handle_states() -> void:
	if input_axes != Vector2.ZERO and $States.current_state.name != "Kick":
		if Input.is_action_pressed("action_run"):
			$States.change_state("Run")
		else:
			$States.change_state("Walk")
	if Input.is_action_just_pressed("action_attack"):
		$States.change_state("Kick")

func _on_states_state_changed(state) -> void:
	#print("[Player State] " + state)
	pass

func save():
	var oPos = get_position()
	var toSave = {
		"name":	self.name,
		"pos_x": oPos.x,
		"pos_y": oPos.y,
		"hp": 10,
	}
	return toSave
	
func load(rData):
	data = rData
	position.x = data.pos_x
	position.y = data.pos_y

