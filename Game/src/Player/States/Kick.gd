extends "res://src/Player/States/Move.gd"

export var ENDING_SPEED = 0.2

var timer
var kick
var dir
var kickTimer = 0.12

func _ready():
	kick = owner.get_node("Attacks").get_node("kick")
	
func enter():
	owner.get_node("AnimationPlayer").set_speed_scale(1)
	owner.motion=owner.motion.normalized()/5
	timer = 0.48
	kickTimer = 0.12 * (timer/0.48)

	if owner.data.dir == "left":
		dir = 180
		owner.get_node("AnimationPlayer").play("Kick_Left")
	elif owner.data.dir == "right":
		dir = 0
		owner.get_node("AnimationPlayer").play("Kick_Right")
	elif owner.data.dir == "up":
		dir = -90
		owner.get_node("AnimationPlayer").play("Kick_Up")
	elif owner.data.dir == "down":
		dir = 90
		owner.get_node("AnimationPlayer").play("Kick_Down")

func update(delta):
	kick.rotation_degrees = dir
	
	if kickTimer > 0:
		kickTimer -= 1*delta
	else:
		kick.get_node("col").disabled = false
			
	if timer > 0:
		timer -= 1*delta
	else:
		kick.get_node("col").disabled = true
		emit_signal("finished","runSlow")
		

func exit():
	owner.motion=owner.motion.normalized()*ENDING_SPEED   
	if owner.data.dir == "left":
		owner.get_node("AnimationPlayer").play("Idle_Left")
	elif owner.data.dir == "right":
		owner.get_node("AnimationPlayer").play("Idle_Right")
	elif owner.data.dir == "up":
		owner.get_node("AnimationPlayer").play("Idle_Up")
	elif owner.data.dir == "down":
		owner.get_node("AnimationPlayer").play("Idle_Down")