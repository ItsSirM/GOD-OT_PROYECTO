class_name Hellhound
extends Enemy

var reload = 35

func _init():
	speed = 12.5
	health = 150
	player_chase = false
	damage = 22
	attackRate = 1.5

func damaged(damage_taken: int):
	health -= damage_taken
	if health <= 0:
		anim.play("DEATH")
		get_node("CollisionShape2D").set_deferred("disabled", true)
		get_node("Area2D/CollisionShape2D").set_deferred("disabled", true)
		get_node("HurtBox/CollisionShape2D").set_deferred("disabled", true)
		get_node("Hitbox/CollisionShape2D").set_deferred("disabled", true)
		get_node("AmmoArea/CollisionShape2D").set_deferred("disabled", false)
