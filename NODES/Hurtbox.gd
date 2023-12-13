class_name HurtBox
extends Area2D

var damage : int

func _init():
	monitorable = false
	collision_mask = 2

func _ready():
	area_entered.connect(self._on_area_entered)
	area_exited.connect(self._on_area_exited)
	
func _on_area_exited(hitbox: Hitbox):
	if owner is Player && !hitbox.owner is Projectile:
		hitbox.timer.stop()

func _on_area_entered(hitbox: Hitbox):
	if owner is Player && !hitbox.owner is Bala2:
		damage = hitbox.damage
		if hitbox.owner is Infected || hitbox.owner is Hellhound || hitbox.owner is Ghost:
			hitbox.timer.timeout.connect(self._on_timeout)
			hitbox.timer.start(hitbox.cooldown)
		else:
			owner.player_damaged(damage)
	
	if owner is Enemy && hitbox.owner is Bala2  || hitbox.owner is Rocket:
		owner.damaged(hitbox.damage)
		
func _on_timeout():
	owner.player_damaged(damage)
