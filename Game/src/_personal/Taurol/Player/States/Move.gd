extends "res://src/_personal/Taurol/Player/States/motion.gd"


# Declare member variables here. Examples:
var speed:=0.0
var velocity:=Vector2()


# Called when the node enters the scene tree for the first time.
func enter():
	speed = 0.0
	velocity = Vector2()
	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	#owner.get_node("AnimationPlayer").play("walk")

func update(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
	update_look_direction(input_direction)
	
	speed=200
	move(speed,get_input_direction())
# Called every frame. 'delta' is the elapsed time since the previous frame.


func move(speed,direction):
	velocity = direction.normalized() * speed
	owner.move_and_slide(velocity)
	if owner.get_slide_count() == 0:
		return
	return owner.get_slide_collision(0)

