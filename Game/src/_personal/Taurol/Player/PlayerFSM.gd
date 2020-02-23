extends "res://src/_personal/Taurol/StateMachine/state_machine.gd"


func _ready():
	states_map = {
		"idle": $Idle,
		"move": $Move,
		"jump": $Jump,
		"hurt": $Hurt,
		"shoot": $Shoot,
	}
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
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
