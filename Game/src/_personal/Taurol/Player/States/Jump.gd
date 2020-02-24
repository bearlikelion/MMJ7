extends "res://src/_personal/Taurol/Player/States/Move.gd"


export var ENDING_SPEED=200
export var DECCELERATION := 300
export var DURATION := 1

var timer :=Timer.new()

func _ready():
	add_child(timer)
	timer.wait_time=DURATION
	timer.connect("timeout",self,"_on_timer_timeout")


func enter():
	if owner.motion==Vector2.ZERO:
		emit_signal("finished","idle")
	owner.motion=owner.motion.normalized()*MAX_SPEED
	timer.start()
	.enter()


func update(delta):
	apply_friction(DECCELERATION*delta)

func _on_timer_timeout():
	
	emit_signal("finished","runFast")

func exit():
	timer.stop()
	owner.motion=owner.motion.normalized()*ENDING_SPEED
