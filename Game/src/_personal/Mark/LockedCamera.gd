extends Camera2D

var grid_size = Vector2()
var grid_position = Vector2()
var camera_offset = Vector2()

onready var player = get_node("../Player")

# Called when the node enters the scene tree for the first time.
func _ready():            
    grid_size = get_viewport_rect().size            
    var start_position = self.position    
    self.position = player.position
    camera_offset = Vector2(start_position - self.position).floor()    
    
    update_grid_position()


func _physics_process(_delta):
    update_grid_position()


func update_grid_position():
    var new_grid_position = calculate_grid_position()
    if grid_position == new_grid_position:
        return
    else:
        grid_position = new_grid_position
        jump_to_grid_position()


func calculate_grid_position():    
    var x = floor(player.position.x / grid_size.x)
    var y = floor(player.position.y / grid_size.y)    
    
    return Vector2(x, y)


func jump_to_grid_position():        
    var move_to = grid_position * grid_size - camera_offset        
    self.position = Vector2(move_to)
