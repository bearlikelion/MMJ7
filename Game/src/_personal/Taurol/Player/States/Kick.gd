extends "res://src/_personal/Taurol/Player/States/Move.gd"

export var ENDING_SPEED = 0.2

var timer
var kick

func _ready():
	kick = owner.get_node("Attacks").get_node("kick")
	
func enter():
	timer = owner.data.kickSpeed
	kick.get_node("col").disabled = false

func update(delta):
	var dir = get_input_direction().angle() * (180/3.14)
	kick.rotation_degrees = dir
	kick.get_node("label").text = str(kick.rotation_degrees)
	if timer > 0:
		timer -= delta*1
	else:
		kick.get_node("col").disabled = true
		emit_signal("finished","runSlow")

func exit():
	owner.motion=owner.motion.normalized()*ENDING_SPEED   
