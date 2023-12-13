extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var SONIDITO = $SonidoBala
var speed = 1200
var health = 100

# Añade una referencia a tu nodo de bala aquí
@onready var bullet = preload("res://NODES/Bala2.tscn")

# Tiempo de intervalo para disparar
var fire_rate = 0.5
var time_since_last_shot = 0.0

func _ready():
	anim.play("QUIETO_ABAJO")
	get_parent().get_node("HUD/Panel/HealthText").text = str(health)

func _physics_process(delta):
	var dir = Input.get_vector("IZQUIERDA","DERECHA","ARRIBA","ABAJO")
	velocity = dir * speed
	
	var mouse_pos = get_global_mouse_position()
	var dir_to_mouse = mouse_pos - global_position

	if dir == Vector2.ZERO:
		if dir_to_mouse.x > 0:
			anim.play("QUIETO_DERECHA")
		elif dir_to_mouse.x < 0:
			anim.play("QUIETO_IZQUIERDA")
		elif dir_to_mouse.y > 0:
			anim.play("QUIETO_ABAJO")
		elif dir_to_mouse.y < 0:
			anim.play("QUIETO_ARRIBA")
	else:
		if dir.x > 0:
			anim.play("MOVERSE_DERECHA")
		elif dir.x < 0:
			anim.play("MOVERSE_IZQUIERDA")
		elif dir.y > 0:
			anim.play("MOVERSE_ABAJO")
		elif dir.y < 0:
			anim.play("MOVERSE_ARRIBA")

	move_and_slide()

	# Añade lógica para disparar
	time_since_last_shot += delta
	if Input.is_action_pressed("DISPARA") and time_since_last_shot >= fire_rate:
		shoot()
		SONIDITO.play()
		time_since_last_shot = 0.0

func shoot():
	var b = bullet.instantiate()
	b.global_position = global_position
	b.direction = global_position.direction_to(get_global_mouse_position())
	get_parent().add_child(b)

func player_damaged(damage: int):
	health -= damage
	get_parent().get_node("HUD/Panel/HealthText").text = str(health)
	if health <= 0:
		get_parent().get_node("HUD/Panel/HealthText").text = str(0)
		self.queue_free()
