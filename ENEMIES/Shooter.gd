class_name Shooter
extends Enemy

@onready var bullet
var time_since_last_shot = 0.0
var player_shoot = false;
	
func _physics_process(delta):
	if player_shoot:
		time_since_last_shot += delta
		if time_since_last_shot >= attackRate:
			shoot()
			time_since_last_shot = 0.0
			
func shoot():
	var b = bullet.instantiate()
	b.global_position = global_position
	b.direction = b.global_position.direction_to(player.global_position).normalized()
	if b.direction.x > 0:
		anim.play("DERECHA")
	elif b.direction.x < 0:
		anim.play("IZQUIERDA")
	elif b.direction.y > 0:
		anim.play("ABAJO")
	elif b.direction.y < 0:
		anim.play("ARRIBA")
	get_parent().add_child(b)
	
func _on_area_2d_body_entered(body):
	if body is Player:
		player = body
		player_shoot = true

func _on_area_2d_body_exited(body):
	if body is Player:
		player_shoot = false
