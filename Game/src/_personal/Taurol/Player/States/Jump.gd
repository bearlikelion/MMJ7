extends "res://src/_personal/Taurol/Player/States/motion.gd"

export var JUMP_SPEED :=800
export var ACCELERATION := 500
export var DECCELERATION:= 300
export var DURATION:=0.5

var timer :=Timer.new()

func _ready():
	add_child(timer)
	timer.wait_time=DURATION
	timer.connect("timeout",self,"_on_timer_timeout")


func enter():
	if owner.motion==Vector2.ZERO:
		emit_signal("finished","walk")
	owner.motion=owner.motion.normalized()*JUMP_SPEED
	timer.start()


func update(delta):
	move(get_input_direction(),delta)

func move(input_direction,delta):
	if input_direction==Vector2.ZERO:
		apply_friction(DECCELERATION*delta)
	else:
		apply_movement(input_direction*ACCELERATION*delta)
	
	update_look_direction(input_direction)
	owner.motion=owner.motion.clamped(JUMP_SPEED)
	owner.motion=owner.move_and_slide(owner.motion)


func apply_friction(amount):
	if owner.motion.length()>amount:
		owner.motion-=owner.motion.normalized()*amount
	else:
		owner.motion=Vector2.ZERO


func apply_movement(accel):
	owner.motion+=accel
	owner.motion=owner.motion.clamped(JUMP_SPEED)


func _on_timer_timeout():
	
	emit_signal("finished","idle")


func exit():
	timer.stop()
	owner.motion=Vector2.ZERO
	print("exit jumping state")
