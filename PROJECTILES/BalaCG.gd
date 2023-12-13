class_name BalaCG
extends Projectile

func _init():
	speed = 1250
	life = 1.2
	damage = 14

func _on_impact(body: Node):
	if body is Player:
		queue_free()
