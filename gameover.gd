extends CanvasLayer


@onready var nambe = $nambe



func _on_otrave_pressed():
	get_tree().change_scene_to_file("res://nivel_1.tscn")


func _on_salida_pressed():
	get_tree().quit()
