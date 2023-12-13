class_name BalaDF
extends Projectile

func _init():
	speed = 850
	life = 1.2
	damage = 55

func _on_impact(body: Node):
	if body is Player:
		queue_free()
