class_name CyberGuard
extends Shooter

var reload = 10

func _init():
	health = 60
	attackRate = 1.35
	bullet = preload("res://PROJECTILES/BalaCG.tscn")

func damaged(damage_taken: int):
	health -= damage_taken
	if health <= 0:
		anim.play("DEATH")
		get_node("CollisionShape2D").set_deferred("disabled", true)
		get_node("Area2D/CollisionShape2D").set_deferred("disabled", true)
		get_node("HurtBox/CollisionShape2D").set_deferred("disabled", true)
		get_node("AmmoArea/CollisionShape2D").set_deferred("disabled", false)
