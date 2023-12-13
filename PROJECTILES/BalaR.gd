class_name BalaR
extends Projectile

func _init():
	speed = 1100
	life = 1.2
	damage = 9

func _on_impact(body: Node):
	if body is Player:
		queue_free()
