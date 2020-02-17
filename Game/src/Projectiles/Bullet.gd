extends KinematicBody2D

export (int) var speed = 125

var direction = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    set_as_toplevel(true)
    pass


func _physics_process(_delta) -> void:
    if direction:        
        var _velocity = move_and_slide(direction * speed)


func _on_Area2D_body_entered(body) -> void:
    if body.is_in_group("Player"):
        # TODO: Damage Player        
        print("Damage Player")
        queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
    queue_free()
