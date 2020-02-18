extends "res://src/_personal/Taurol/StateMachine/state_machine.gd"

var can_run:=true

func _ready():
	states_map = {
		"idle": $Idle,
		"move": $Move,
		"run": $Run,
		"jump": $Jump,
		"hurt": $Hurt,
		"shoot": $Shoot,
	}


func _input(event):
	if event is InputEventKey:
		if event.scancode==KEY_P and !event.pressed and can_run:
			_change_state("run")
			can_run=false
	
	._input(event)


func _change_state(state_name):
	"""
	The base state_machine interface this node extends does most of the work
	"""
	if not _active:
		return
	if state_name in ["hurt"]:
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)


func _on_AnimationPlayer_animation_finished(anim_name):
	._on_animation_finished(anim_name)


func _on_Run_can_run():
	can_run=true
