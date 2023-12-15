class_name Ghost
extends Enemy

var reload = 10

func _init():
	speed = 8.5
	health = 60
	player_chase = false
	damage = 14
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
