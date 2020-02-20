extends KinematicBody2D


var look_direction:=Vector2(1,0)
var motion := Vector2.ZERO
var rel_velocity :=Vector2.ZERO

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	
	
	var test:=0
	#motion=move_and_slide(motion)
	if Input.is_action_pressed("test"):
		test=40
		print(motion.length()+test)
	motion=move_and_slide(motion.normalized()*(motion.length()+test))
	
