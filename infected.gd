class_name Infected
extends Enemy

func _init():
	speed = 8
	health = 20
	player_chase = false
	damage = 9
	attackRate = 1.5

func damaged(damage_taken: int):
	health -= damage_taken
	if health <= 0:
		player_chase = false
		anim.play("DEATH")
		get_node("CollisionShape2D").set_deferred("disabled", true)
		get_node("Area2D/CollisionShape2D").set_deferred("disabled", true)
		get_node("Hitbox/CollisionShape2D").set_deferred("disabled", true)
		get_node("HurtBox/CollisionShape2D").set_deferred("disabled", true)
