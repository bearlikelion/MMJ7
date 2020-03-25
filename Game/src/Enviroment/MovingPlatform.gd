class_name MovingPlatform

extends Area2D

var player_entered:=false
var player=null
var on_board:=[]
var platform_rel_pos:=self.position
var velocity=Vector2.ZERO

func _ready():
	connect("body_entered",self,"_on_MovingPlatform_body_entered")
	connect("body_exited",self,"_on_MovingPlatform_body_exited")

func _process(delta):
	if platform_rel_pos!=position:
		velocity=position-platform_rel_pos
		platform_rel_pos=position
	if player_entered:
		player.rel_velocity=velocity
	if on_board.size()>0:
		for n in range(on_board.size()):
			on_board[n].position+=velocity


func _on_MovingPlatform_body_entered(body):
	if body.is_in_group("walls"):
		return
	if body.is_in_group("player"):
		player=body
		player_entered=true
	on_board.push_back(body)


func _on_MovingPlatform_body_exited(body):
	if body.is_in_group("walls"):
		return
	if body.is_in_group("player"):
		player_entered=false
		player=null
	on_board.erase(body)
