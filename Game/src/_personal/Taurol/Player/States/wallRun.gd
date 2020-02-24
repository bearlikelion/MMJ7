extends "res://src/_personal/Taurol/Player/States/Move.gd"


export var ACCELERATION := 2000
export var DECCELERATION:= 3000
export var DURATION:=1


var timer :=Timer.new()
var mov_direction  :=Vector2.ZERO
var wall_normal:= Vector2.ZERO 


func _ready():
	add_child(timer)
	timer.wait_time=DURATION
	timer.connect("timeout",self,"_on_timer_timeout")


func enter():
	owner.on_ground=false
	
	wall_normal = owner.wall_raycast.get_collision_normal()
	mov_direction  =-owner.motion.reflect(wall_normal).normalized()
	
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
	.enter()


func exit():
	timer.stop()
	owner.on_ground=true


func update(delta):
	
	var input_direction = get_input_direction()  
	if (abs(input_direction.angle_to(wall_normal))<PI/2 and input_direction!=Vector2.ZERO) or !owner.wall_raycast.is_colliding():
		emit_signal("finished", "runSlow")
		return
	else:
		move(mov_direction, delta,ACCELERATION,DECCELERATION)
    

func _on_timer_timeout():
	emit_signal("finished", "runSlow")
