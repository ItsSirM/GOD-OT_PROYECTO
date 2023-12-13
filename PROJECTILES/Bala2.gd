class_name Bala2
extends Projectile

func _init():
	speed = 1500
	life = 1.2
	damage = 10

func _on_impact(body: Node):
	if !body is Player:
		queue_free()
