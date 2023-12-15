class_name Deformer
extends Shooter

var reload = 80

func _init():
	health = 400
	attackRate = 1.8
	bullet = preload("res://PROJECTILES/BalaDF.tscn")

func damaged(damage_taken: int):
	health -= damage_taken
	if health <= 0:
		anim.play("DEATH")
		get_node("CollisionShape2D").set_deferred("disabled", true)
		get_node("Area2D/CollisionShape2D2").set_deferred("disabled", true)
		get_node("HurtBox/CollisionShape2D2").set_deferred("disabled", true)
		get_node("AmmoArea/CollisionShape2D").set_deferred("disabled", false)
