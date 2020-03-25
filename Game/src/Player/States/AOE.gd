extends "res://src/Player/States/Move.gd"

export var ENDING_SPEED = 0.2

var timer
var attack
var speed
export var decelSpeed = 0.1

func _ready():
	attack = owner.get_node("Attacks").get_node("aoe")
	
func enter():
	timer = owner.data.aoeSpeed
	attack.get_node("col").disabled = false
	owner.motion=owner.motion.normalized()*decelSpeed   
	attack.get_node("attackSprite").visible = true

func update(delta):
	if timer > 0:
		timer -= delta*1
	else:
		attack.get_node("col").disabled = true
		emit_signal("finished","runSlow")

func exit():
	owner.motion=owner.motion.normalized()*ENDING_SPEED   
	attack.get_node("attackSprite").visible = false
