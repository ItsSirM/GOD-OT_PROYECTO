extends Area2D

var speed = 1500
var direction = Vector2.ZERO

# Añade un Timer para controlar cuánto tiempo existe la bala
var timer = Timer.new()

func _ready():
	# Configura el Timer para que espere 5 segundos, luego se autodestruya
	timer.set_wait_time(5)
	timer.set_one_shot(true)
	add_child(timer)
	timer.start()

func _physics_process(delta):
	position += direction * speed * delta

func set_direction(dir):
	direction = dir.normalized()

# Cuando el Timer llega a cero, la bala se autodestruye
func _on_Timer_timeout():
	queue_free()
