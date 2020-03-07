extends Area2D

onready var player = get_parent().get_parent().get_parent()

func _on_right_body_entered(body):
	_processAttack(body, "right")
func _on_left_body_entered(body):
	_processAttack(body, "left")
func _on_down_body_entered(body):
	_processAttack(body, "down")
func _on_up_body_entered(body):
	_processAttack(body, "up")

func _processAttack(body, dir):
	if body.name != "Player":
		print(dir + " " + body.name)
		body._damage(position)