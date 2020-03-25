extends "res://src/Player/States/Move.gd"


export var REACTIVE_DECCEL :=false
export var MIN_SPEED :=0
export var JOGGING_ACCELERATION := 2000
export var JOGGING_DECCELERATION:= 1000
export var RUNNING_ACCELERATION := 2000
export var RUNNING_DECCELERATION:= 1000

func enter():
	owner.on_ground=true
	.enter()

func update(delta):
	
	var accel:=0
	var deccel:=0
	var input_direction = get_input_direction()
	if not input_direction:
		if owner.motion==Vector2.ZERO:
			emit_signal("finished", "idle")
	
	if Input.is_action_pressed("action_run"):
		accel=RUNNING_ACCELERATION
		deccel=RUNNING_DECCELERATION
	if !Input.is_action_pressed("action_run"):
		accel=JOGGING_ACCELERATION
		deccel=JOGGING_DECCELERATION
	
	if Input.is_action_pressed("up"):
		owner.data.dir = "up"
		owner.get_node("AnimationPlayer").play("Idle_Up")
	elif Input.is_action_pressed("down"):
		owner.data.dir = "down"
		owner.get_node("AnimationPlayer").play("Idle_Down")
	elif Input.is_action_pressed("left"):
		owner.data.dir = "left"
		owner.get_node("AnimationPlayer").play("Idle_Left")
	elif Input.is_action_pressed("right"):
		owner.data.dir = "right"
		owner.get_node("AnimationPlayer").play("Idle_Right")
	
	move(input_direction.normalized(),accel,deccel,delta)


func apply_friction(amount):
	if REACTIVE_DECCEL:
		if owner.motion.length()>amount*owner.motion.length():
			owner.motion-=owner.motion*amount
		else:
			owner.motion=Vector2.ZERO
	elif owner.motion.length()>amount:
		owner.motion-=owner.motion.normalized()*amount
	else:
		owner.motion=Vector2.ZERO

