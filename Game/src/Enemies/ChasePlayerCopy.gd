extends KinematicBody2D

export (int) var speed = 75
export var isLoaded = false
var data = {
	"pos_x": position.x,
	"pos_y": position.y,
	"testVAr": "Boy",
	}
var velocity = Vector2.ZERO
var player = null

func _physics_process(_delta) -> void:
	velocity = Vector2.ZERO
	if player:
			velocity = position.direction_to(player.position) * speed
	velocity = move_and_slide(velocity)
	$Label.text = data.testVAr

func _on_AgroRadius_body_entered(body) -> void:
	if body.is_in_group("player"):
		player = body
		data.testVAr = "I see a player"
	
func _on_AgroRadius_body_exited(_body) -> void:
	player = null
	
func save():
	var oPos = get_position()
	var toSave = {
		"name":	self.name,
		"pos_x": oPos.x,
		"pos_y": oPos.y,
		"testVAr": data.testVAr,
	}
	return toSave
func load(rData):
	data = rData
	position.x = data.pos_x
	position.y = data.pos_y
	print(rData.testVAr)

