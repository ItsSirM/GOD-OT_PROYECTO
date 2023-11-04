extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
var speed = 800

# Añade una referencia al nodo del jugador
var player

func _ready():
	# Define la referencia al jugador aquí
	player = get_node("PLAYER")
	anim.play("QUIETO_ABAJO")

func _physics_process(delta):
	var dir = player.global_position - global_position
	velocity = dir.normalized() * speed

	# Aquí puedes programar qué animación se debe reproducir
	# Por ejemplo, podrías reproducir diferentes animaciones dependiendo de la dirección del movimiento:
	if dir.x > 0:
		anim.play("derecha")
	elif dir.x < 0:
		anim.play("izquierda")
	elif dir.y > 0:
		anim.play("abajo")
	elif dir.y < 0:
		anim.play("arriba")
	else:
		anim.stop()
