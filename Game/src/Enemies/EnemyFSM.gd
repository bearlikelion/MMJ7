extends "res://src/StateMachine/state_machine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"chase":$Chase,
		"damaged":$Damaged,
		"stun":$Stunned,
		"death":$Death,
		"dead":$Dead,
	}

func _process(delta):
	pass

func _change_state(state_name):
	"""
	The base state_machine interface this node extends does most of the work
	"""
	if not _active:
		return
	if state_name in states_map:
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)

func _on_Demon_damageTaken():
	_change_state("damaged")
func _on_Demon_stunTaken():
	_change_state("stun")
