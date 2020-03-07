extends KinematicBody2D

export (int) var default_speed = 125

var direction = null
var speed = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !speed:        
		speed = default_speed
		
	set_as_toplevel(true)    


func _physics_process(_delta) -> void:
	if direction:        
		var _velocity = move_and_slide(direction * speed)    


func _on_Area2D_body_entered(body) -> void:    
	match body.name:
		"Player":
			# TODO: Damage Player
			#body.damage()
			queue_free()
		"TileMap":        
			queue_free()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
