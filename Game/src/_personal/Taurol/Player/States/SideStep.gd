extends "res://src/_personal/Taurol/Player/States/Move.gd"


export var DURATION:=0.1
export(NodePath) var RAYCASTS

var timer :=Timer.new()
var ACCELERATION := 500
var DECCELERATION:= 300


func _ready():
	add_child(timer)
	timer.wait_time=DURATION
	timer.connect("timeout",self,"_on_timer_timeout")


func enter():
	if owner.motion==Vector2.ZERO:
		emit_signal("finished","idle")
		return
	owner.motion=owner.motion.normalized()*MAX_SPEED
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
	move(owner.motion.normalized(),delta,ACCELERATION,DECCELERATION)


func _on_timer_timeout():
	emit_signal("finished","runSlow")


func exit():
	timer.stop()
	print("exit sidestep state")
