class_name HighCyberGuard
extends Shooter

var reload = 100

func _init():
	health = 1000
	attackRate = 2
	bullet = preload("res://PROJECTILES/BalaLVL.tscn")
