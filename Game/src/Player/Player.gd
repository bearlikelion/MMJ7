extends KinematicBody2D

export (int) var speed = 200

var velocity := Vector2.ZERO
var input_axes := Vector2.ZERO
var is_running := false
var queued_action

func _ready():
    $States.start()
    pass

func _physics_process(_delta):
    add_to_group("player")
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

    if Input.is_action_pressed("action_run") && $States.current_state.name != "Run":
        # is_running = true
        $States.change_state("Run")
    elif Input.is_action_just_released("action_run") && velocity != Vector2.ZERO:
        # is_running = false
        $States.change_state("Walk")
    elif Input.is_action_just_released("action_run") && velocity == Vector2.ZERO:
        $States.change_state("Idle")

    # Normalize so diagonal movement isn't faster
    velocity = velocity.normalized() * speed


func _on_states_state_changed(state):
    print("[State]: " + state)
    pass # Replace with function body.
