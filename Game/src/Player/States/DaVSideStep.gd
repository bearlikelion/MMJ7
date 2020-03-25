extends "res://src/_personal/Taurol/Player/States/motion.gd"


export var SIDE_STEP_SPEED :=700
export var DURATION:=0.1
export(NodePath) var RAYCASTS

var timer :=Timer.new()
var ACCELERATION := 500
var DECCELERATION:= 300


func _ready():
	add_child(timer)
	timer.wait_time=DURATION
	timer.connect("timeout",self,"_on_timer_timeout")
	for raycast in get_node(RAYCASTS).get_children():
		raycast.add_exception(owner)

func enter():
	if owner.motion==Vector2.ZERO:
		emit_signal("finished","idle")
		return
	owner.motion=owner.motion.normalized()*SIDE_STEP_SPEED
	timer.start()


func update(delta):
	for raycast in get_node(RAYCASTS).get_children():
		
		if raycast.is_colliding():
			print(raycast.get_collider())
			if raycast.get_collider().is_in_group("walls"):
				owner.wall_raycast = raycast
				print(owner.wall_raycast)
				match raycast.name:
					"south_cast":
						owner.wall_dir = owner.WallDirections.SOUTH
						print("a")
					"north_cast":
						owner.wall_dir = owner.WallDirections.NORTH
						print("b")
					"east_cast":
						owner.wall_dir = owner.WallDirections.EAST
						print("c")
					"west_cast":
						owner.wall_dir = owner.WallDirections.WEST
						print("d")
				emit_signal("finished", "wallrun")
	move(owner.motion.normalized(),delta)


func move(input_direction,delta):
	if input_direction==Vector2.ZERO:
		apply_friction(DECCELERATION*delta)
	else:
		apply_movement(input_direction*ACCELERATION*delta)   
	update_look_direction(input_direction)
	owner.motion=owner.motion.clamped(SIDE_STEP_SPEED)
	owner.motion=owner.move_and_slide(owner.motion)


func apply_friction(amount):
	if owner.motion.length()>amount:
		owner.motion-=owner.motion.normalized()*amount
	else:
		owner.motion=Vector2.ZERO


func apply_movement(accel):
	owner.motion+=accel
	owner.motion=owner.motion.clamped(SIDE_STEP_SPEED)


func _on_timer_timeout():
	emit_signal("finished","runFast")


func exit():
	timer.stop()
    #owner.motion=Vector2.ZERO
	print("exit sidestep state")
