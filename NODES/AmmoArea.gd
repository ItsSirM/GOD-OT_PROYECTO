class_name AmmoArea
extends Area2D

func _ready():
	body_entered.connect(self._on_body_entered)
	body_exited.connect(self._on_body_exited)
	
func _on_body_entered(player: Player):
	player.reload = owner.reload
	player.canReload = true
	player.reloadZone = self
	get_parent().get_parent().get_node("HUD/Label").visible = true
func _on_body_exited(player: Player):
	player.reload = 0
	player.canReload = false
	player.reloadZone = null
	get_parent().get_parent().get_node("HUD/Label").visible = false
