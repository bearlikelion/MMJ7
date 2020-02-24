extends "res://src/_personal/Taurol/Player/States/Move.gd"


export var DURATION:=0.1
export(NodePath) var RAYCASTS

var timer :=Timer.new()
var ACCELERATION := 500
var DECCELERATION:= 300


func _ready():
	for raycast in get_node(RAYCASTS).get_children():
		raycast.add_exception(owner)
	add_child(timer)
	timer.wait_time=DURATION
	timer.connect("timeout",self,"_on_timer_timeout")


func enter():
	if owner.motion==Vector2.ZERO:
		emit_signal("finished","idle")
		return
	owner.motion=owner.motion.normalized()*MAX_SPEED
	timer.start()
	owner.modulate=Color.brown
	.enter()


func update(delta):
	for raycast in get_node(RAYCASTS).get_children():
		
		if raycast.is_colliding():
			print(raycast.get_collider())
			if raycast.get_collider().is_in_group("walls"):
				owner.wall_raycast = raycast
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
	owner.modulate=Color(1,1,1,1)
