extends KinematicBody2D

export (int) var speed = 75
export var isLoaded = false
var data = {
	"pos_x": position.x,
	"pos_y": position.y,
	"testVAr": "Boy",
	"hp": 5,
	}
var velocity = Vector2.ZERO
var player = null
var z = 0

func _ready():
	$States.start()
	$States.change_state("Idle")

func _physics_process(_delta) -> void:
	velocity = move_and_slide(velocity)
	
	if z > 0:
		z -= _delta*1
		
	if data.hp <= 0:
		queue_free()
	

func _on_AgroRadius_body_entered(body) -> void:
	if body.is_in_group("player"):
		player = body
	
func _on_AgroRadius_body_exited(_body) -> void:
	player = null

func _damage(pos):
	$States.change_state("Damage")

func _stunAttack():
	z = 5
	
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



func _on_States_state_changed(state):
	pass # Replace with function body.
