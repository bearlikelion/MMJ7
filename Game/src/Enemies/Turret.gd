extends KinematicBody2D

export (int) var projectile_speed = 125

var player = null

const bullet_scene = "res://src/Projectiles/Bullet.tscn"

func _physics_process(_delta) -> void:
    if player:
        self.look_at(player.position)


func fire() -> void:
    var scene = load(bullet_scene)
    var bullet = scene.instance()
    bullet.direction = (player.position - self.position).normalized()
    if projectile_speed:    
        bullet.speed = projectile_speed
    add_child(bullet)
    move_child(bullet, 0)


func _on_AgroRadius_body_entered(body) -> void:
    if body.is_in_group("Player"):
        print("[Turret] Targeting player!")
        $FireRate.start()
        player = body


func _on_AgroRadius_body_exited(body) -> void:
    if body.is_in_group("Player"):
        $FireRate.stop()
        print("[Turret] Lost target")
        player = null


func _on_FireRate_timeout() -> void:
    if player:
        fire()
