extends Node2D

# Asumiendo que tienes una referencia al jugador
var jugador = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Aquí debes obtener la referencia al jugador
	jugador = get_node("PLAYER")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Pausa"):
		get_tree().paused = not get_tree().paused
		$PauseMenu.visible = not $PauseMenu.visible
		# Si el menú de pausa está visible, lo movemos a la posición del jugador
		if $PauseMenu.visible:
			$PauseMenu.position = jugador.position

func _on_salir_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
