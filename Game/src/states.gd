extends Node

# - >| Finite State Machine |

signal state_changed(state)

var character: KinematicBody2D = owner;
var last_direction: Vector2;

var states: Dictionary = {};

var current_state: Node;
var previous_state: Node;

var _active: bool = false setget set_active;


func start() -> void:
    set_active(true);
    get_states_nodes();
    if states['Idle']:
        change_state('Idle');
    else:
        print("No idle state")


func get_states_nodes() -> void:
    for state_node in get_children():
        if state_node in states:
            continue

        states[state_node.name] = state_node;


func _physics_process(delta) -> void:
    current_state.update(delta);


func change_state(state_name) -> void:
    if !_active:
        return

    if state_name in states:
        if current_state:
            previous_state = current_state;
            if current_state.has_method("exit"):
                current_state.exit();

        current_state = states[state_name];
        if current_state.has_method("enter"):
            current_state.enter();
        emit_signal("state_changed", state_name)


func set_active(value) -> void:
    _active = value;
    set_physics_process(value);
    set_process_input(value);

    if !_active:
        current_state = null;
