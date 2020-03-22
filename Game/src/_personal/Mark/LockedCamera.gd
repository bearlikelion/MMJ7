extends Camera2D

onready var player = get_node("../Player")

func _physics_process(_delta):
	position = player.position