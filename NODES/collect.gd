class_name collect
extends Area2D

func _ready():
	body_entered.connect(self._on_body_entered)
	
func _on_body_entered(player: Player):
	if get_parent().name == "shotgun":
		player.shotgun = true
		player.ammo += 50
	elif get_parent().name == "chaingun":
		player.chaingun = true
		player.ammo += 150
	elif get_parent().name == "launcher":
		player.launcher = true
		player.ammo += 300
	get_parent().get_parent().get_node("HUD/Panel2/AmmoText").text = str(player.ammo)
	get_parent().queue_free()
