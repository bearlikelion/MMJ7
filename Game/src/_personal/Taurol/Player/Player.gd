extends KinematicBody2D

var data = {
	"pos_x": position.x,
	"pos_y": position.y,
	"hp": 10,
	"maxHp": 10,
	"kickSpeed": 0.3,
	"aoeSpeed": 0.5,
	}


enum WallDirections {
	NORTH,
	SOUTH,
	EAST,
	WEST,
   }


var look_direction:=Vector2(1,0)
var motion := Vector2.ZERO
var rel_velocity :=Vector2.ZERO
var on_ground:=true

var wall_dir := 0
var wall_raycast: Node

func _ready():
	pass # Replace with function body.

func _process(delta):
	motion=move_and_slide(motion)

func damage():
	pass