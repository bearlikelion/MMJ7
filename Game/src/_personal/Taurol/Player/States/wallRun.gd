extends "res://src/_personal/Taurol/Player/States/motion.gd"

export var MAX_SPEED :=200
export var ACCELERATION := 2000
export var DECCELERATION:= 3000
export var DURATION:=1


var timer :=Timer.new()


func _ready():
	add_child(timer)
	timer.wait_time=DURATION
	timer.connect("timeout",self,"_on_timer_timeout")


func enter():
	owner.motion = Vector2.ZERO 
	owner.look_direction = Vector2(owner.look_direction.x*-1,0)
	#if owner.look_direction.x != 0:
	#	owner.get_node("Sprite").set_scale(Vector2(owner.look_direction.x, 1))
	match owner.wall_dir:
		0:
			print("0")
		1:
			print("1")
		2:
			print("2")
		3:
			print("3")
	timer.start()


func exit():
	timer.stop()


func update(delta):
	var wall_normal: Vector2 = owner.wall_raycast.get_collision_normal()
	var input_direction = get_input_direction()
    
	if input_direction:
		print("exit")
		emit_signal("finished", "runSlow")
	else:
		move(wall_normal, delta)
    
    
func move(input_direction,delta):
	if input_direction==Vector2.ZERO:
		apply_friction(DECCELERATION*delta)
	else:
		apply_movement(input_direction*ACCELERATION*delta)
	update_look_direction(input_direction)
	owner.motion=owner.move_and_slide(owner.motion)


func apply_friction(amount):
	if owner.motion.length()>amount:
		owner.motion-=owner.motion.normalized()*amount
	else:
		owner.motion=Vector2.ZERO


func apply_movement(accel):
	owner.motion+=accel
	owner.motion=owner.motion.clamped(MAX_SPEED)


func _on_timer_timeout():
	emit_signal("finished", "runSlow")
