extends KinematicBody2D

export (int) var speed = 200
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var velocity := Vector2.ZERO

func get_input() -> void:
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
    get_input()
    velocity = move_and_slide(velocity)
