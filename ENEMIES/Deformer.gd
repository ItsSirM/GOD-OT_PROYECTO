class_name Deformer
extends Shooter

var reload = 50

func _init():
	health = 400
	attackRate = 1.8
	bullet = preload("res://PROJECTILES/BalaDF.tscn")
