class_name Rocket
extends Projectile

@onready var hitbox := $Hitbox

func _init():
	speed = 2000
	life = 1.2
	damage = 120
	
func _on_impact(body: Node):
	if !body is Player:
		get_node("Hitbox/CollisionShape2D").set_deferred("disabled", false)
		timer.timeout.connect(self.queue_free)
		timer.start(0.05)
