extends "res://src/_personal/Taurol/Player/States/Move.gd"

export var JUMP_SPEED:=500
export var ENDING_SPEED:=200
export var ACCELERATION:=400
export var DECCELERATION := 300
export var DURATION := 1


var timer := Timer.new()


func _ready():
	add_child(timer)
	timer.wait_time=DURATION
	timer.connect("timeout",self,"_on_timer_timeout")


func enter():
	if owner.motion==Vector2.ZERO:
		emit_signal("finished","idle")
	owner.motion+=owner.motion.normalized()*JUMP_SPEED
	timer.start()
	.enter()


func update(delta):
	apply_friction(DECCELERATION*delta)
	var input_dir=get_input_direction()
	move(input_dir,ACCELERATION,DECCELERATION,delta)


func _on_timer_timeout():
	emit_signal("finished","runFast")


func exit():
	timer.stop()
	#owner.motion=owner.motion.normalize()*(ENDING_SPEED+owner.motion.length())
	owner.motion+=ENDING_SPEED*get_input_direction()
