extends Area2D

onready var player = get_parent().get_parent().get_parent()

func _ready():
	connect("body_entered", self, "_body_entered")

func _body_entered(body):
	if body.name != "Player" and body.name != "TileMap":
		print(body.name)
		body.stun()