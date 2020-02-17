extends KinematicBody2D

export (int) var default_speed = 125

var direction = null
var speed = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    if !speed:
        print("[BULLET] Speed not set defauling to " + default_speed)
        speed = default_speed
        
    set_as_toplevel(true)    


func _physics_process(_delta) -> void:
    if direction:        
        var _velocity = move_and_slide(direction * speed)
    else:
        print("[BULLET] no direction set")


func _on_Area2D_body_entered(body) -> void:
    if body.is_in_group("Player"):
        # TODO: Damage Player        
        print("[BULLET] Damage Player")
        queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
    queue_free()
