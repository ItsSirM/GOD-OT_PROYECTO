class_name HurtBox
extends Area2D

var damage : int

func _init():
	monitorable = false
	collision_mask = 2

func _ready():
	area_entered.connect(self._on_area_entered)
	
func _on_area_entered(hitbox: Hitbox):
	if owner.has_method("player_damaged") && !hitbox.owner is Bala2:
		damage = hitbox.damage
		hitbox.timer.timeout.connect(self._on_timeout)
		hitbox.timer.start(hitbox.cooldown)
	
	if owner.has_method("damaged"):
		owner.damaged(hitbox.damage)
		
func _on_timeout():
	owner.player_damaged(damage)
