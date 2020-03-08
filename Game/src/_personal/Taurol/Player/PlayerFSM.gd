extends "res://src/_personal/Taurol/StateMachine/state_machine.gd"

var can_run:=true


func _ready():
	states_map = {
		"idle": $Idle,
		"runSlow": $runSlow,
		"runMedium":$runMedium,
		"runFast": $runFast,
		"jump": $Jump,
		"sidestep":$SideStep,
		"wallrun":$wallRun,
		"hurt": $Hurt,
		"shoot": $Shoot,
		"kick": $Kick,
		"aoe": $AOE,
	}


func _input(event):
	if event is InputEventKey:
		if event.scancode==KEY_T and !event.pressed:
			_change_state("jump")
		if event.scancode==KEY_Q and !event.pressed:
			_change_state("sidestep")
		if event.scancode==KEY_X and !event.pressed:
			_change_state("kick")
		if event.scancode==KEY_Z and !event.pressed:
			_change_state("aoe")
		#if event.scancode==KEY_Q and !event.pressed and current_state.get_name()!="SideStep":
		#	_change_state("davsidestep")
	._input(event)
		
	._input(event)

func _process(delta):
	get_parent().get_node("Debug").get_node("Label").text = current_state.get_name()

func _change_state(state_name):
	"""
	The base state_machine interface this node extends does most of the work
	"""
	if not _active:
		return
	if state_name in ["hurt"]:
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)
	print(current_state.get_name())


func _on_AnimationPlayer_animation_finished(anim_name):
	._on_animation_finished(anim_name)


func _on_Run_can_run():
	can_run=true
