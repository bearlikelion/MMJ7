extends KinematicBody2D



enum WallDirections {
	NORTH,
	SOUTH,
	EAST,
	WEST,
   }

var directiontest:=Vector2(1,0)
var look_direction:=Vector2(1,0)
var motion := Vector2.ZERO
var rel_velocity :=Vector2.ZERO
var on_ground:=true

var wall_dir := 0
var wall_raycast: Node

func _ready():
	var a=Fmod.FMOD_SPEAKERMODE_RAW
	pass # Replace with function body.

func _process(delta):
	motion=move_and_slide(motion)

func damage():
	pass