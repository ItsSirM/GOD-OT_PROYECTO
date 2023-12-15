class_name collect
extends Area2D

var sICON = preload("res://STYLES/shotgunICON.tres")
var cICON = preload("res://STYLES/chaingunICON.tres")
var rICON = preload("res://STYLES/launcherICON.tres")

func _ready():
	body_entered.connect(self._on_body_entered)
	
func _on_body_entered(player: Player):
	if get_parent().name == "shotgun":
		player.shotgun = true
		player.ammo += 50
		get_parent().get_parent().get_node("HUD/Weapon2/Panel").add_theme_stylebox_override("panel", sICON)
	elif get_parent().name == "chaingun":
		player.chaingun = true
		player.ammo += 150
		get_parent().get_parent().get_node("HUD/Weapon3/Panel").add_theme_stylebox_override("panel", cICON)
	elif get_parent().name == "launcher":
		player.launcher = true
		player.ammo += 300
		get_parent().get_parent().get_node("HUD/Weapon4/Panel").add_theme_stylebox_override("panel", rICON)
	get_parent().get_parent().get_node("HUD/Panel2/AmmoText").text = str(player.ammo)
	get_parent().queue_free()
