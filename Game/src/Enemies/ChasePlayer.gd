extends KinematicBody2D

signal damageTaken
signal stunTaken

export (int) var speed = 75
export var isLoaded = false
var data = {
	"pos_x": position.x,
	"pos_y": position.y,
	"testVAr": "Boy",
	"hp": 5,
	"state": "alive"
	}
var velocity = Vector2.ZERO
var player = null

func _physics_process(_delta) -> void:
	velocity = move_and_slide(velocity)
	$Label.text = str(data.hp)
	$Label4.text = str( $AgroRadius.get_node("CollisionShape2D").disabled )

func damage():
	emit_signal("damageTaken")
func stun():
	emit_signal("stunTaken")

func _on_AgroRadius_body_entered(body) -> void:
	if body.is_in_group("player"):
		player = body
	
func _on_AgroRadius_body_exited(_body) -> void:
	if _body.is_in_group("player"):
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
