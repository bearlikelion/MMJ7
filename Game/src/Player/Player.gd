extends KinematicBody2D

export var speed := 200

var velocity := Vector2.ZERO

func handle_input() -> void:
    velocity = Vector2.ZERO
    
    if Input.is_action_pressed('up'):
        velocity.y -= 1
    if Input.is_action_pressed('down'):
        velocity.y += 1
    if Input.is_action_pressed('left'):
        velocity.x -= 1
    if Input.is_action_pressed('right'):
        velocity.x += 1        
    
    # Normalize so diagonal movement isn't faster
    velocity = velocity.normalized() * speed
    
func _physics_process(_delta : float) -> void:
    handle_input()
    velocity = move_and_slide(velocity)
