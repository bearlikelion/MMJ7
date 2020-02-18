extends "res://src/_personal/Taurol/Player/States/Move.gd"

signal can_run

export(float) var running_duration=10
export(float) var running_cooldown_time=5

onready var run_timer:Timer
onready var run_cooldown_timer:Timer


func _ready():
	run_timer = Timer.new()
	run_timer.wait_time=running_duration
	run_timer.connect("timeout",self,"_on_run_timer_timeout")
	
	run_cooldown_timer = Timer.new()
	run_cooldown_timer.wait_time=running_cooldown_time
	run_cooldown_timer.connect("timeout",self,"_on_run_cooldown_timer_timeout")
	
	add_child(run_timer)
	add_child(run_cooldown_timer)

func update(delta):
	var input_direction = get_input_direction()
	move(input_direction,delta)
	

func enter():
	if !run_cooldown_timer.is_stopped():
		emit_signal("finished", "move")
	else:
		run_timer.start()
		.enter()


func _on_run_timer_timeout()->void:
	run_cooldown_timer.start()
	run_timer.stop()
	print("running end")
	emit_signal("finished", "move")


func _on_run_cooldown_timer_timeout()->void:
	emit_signal("can_run")
	print("can run again")
	run_cooldown_timer.stop()


func exit():
	run_timer.stop()
