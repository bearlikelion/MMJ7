extends Camera2D

var grid_size = Vector2()
var grid_position = Vector2()
var camera_offset = Vector2()

onready var player = get_node("../Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    grid_size = get_viewport_rect().size
    #var start_position = self.position
    #self.position = player.position
    #camera_offset = Vector2(start_position - self.position).floor()
    update_grid_position()


func _physics_process(_delta) -> void:
    update_grid_position()


func update_grid_position() -> void:
    var new_grid_position = calculate_grid_position()
    if grid_position == new_grid_position:
        return
    else:
        grid_position = new_grid_position
        jump_to_grid_position()


func calculate_grid_position() -> Vector2:
    var x = floor(player.global_position.x / grid_size.x)
    var y = floor(player.global_position.y / grid_size.y)

    return Vector2(x, y)


func jump_to_grid_position() -> void:
    var move_to = grid_position * grid_size - camera_offset
    self.position = Vector2(move_to)
