class_name HighCyberGuard
extends Shooter

var reload = 100

func _init():
	health = 1000
	attackRate = 2
	bullet = preload("res://PROJECTILES/BalaLVL.tscn")

func damaged(damage_taken: int):
	health -= damage_taken
	if health <= 0:
		get_tree().change_scene_to_file("res://ENEMIES/ganar.tscn")
		anim.play("DEATH")
		get_node("CollisionShape2D").set_deferred("disabled", true)
		get_node("Area2D/CollisionShape2D").set_deferred("disabled", true)
		get_node("HurtBox/CollisionShape2D").set_deferred("disabled", true)
		get_node("AmmoArea/CollisionShape2D").set_deferred("disabled", false)
		
		
