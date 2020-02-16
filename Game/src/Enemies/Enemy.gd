extends KinematicBody2D

export (int) var speed = 75

var velocity = Vector2.ZERO
var player = null

func _physics_process(delta):
    velocity = Vector2.ZERO
    if player:
            velocity = position.direction_to(player.position) * speed
    velocity = move_and_slide(velocity)
    

func _on_AgroRadius_body_entered(body):    
    if body.is_in_group("Player"):
        player = body
    
func _on_AgroRadius_body_exited(body):
    player = null
