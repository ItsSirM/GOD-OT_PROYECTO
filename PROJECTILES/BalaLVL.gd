class_name BalaLVL
extends Projectile

func _init():
	speed = 875
	life = 1.2
	damage = 72

func _on_impact(body: Node):
	if body is Player:
		queue_free()
