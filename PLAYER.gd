class_name Player
extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
var speed = 1200
var health = 100
var weapon = "PISTOL"
var ammo = 50
var rng = RandomNumberGenerator.new()

var shotgun = false
var chaingun = false
var launcher = false

var reload = 0
var canReload = false
var reloadZone : AmmoArea

# Añade una referencia a tu nodo de bala aquí
@onready var bullet = preload("res://PROJECTILES/Bala2.tscn")
@onready var rocket = preload("res://PROJECTILES/Rocket.tscn")

var wgrad1 = preload("res://STYLES/WGRAD1.tres")
var wgrad2 = preload("res://STYLES/WGRAD2.tres")

# Tiempo de intervalo para disparar
var fire_rate = 0.5
var time_since_last_shot = 0.0

func _ready():
	anim.play("QUIETO_ABAJO")
	get_parent().get_node("HUD/Panel/HealthText").text = str(health)
	get_parent().get_node("HUD/Panel2/AmmoText").text = str(ammo)

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
	# Weapon Change
	if Input.is_action_just_pressed("Weapon1"):
		weapon = "PISTOL"
		fire_rate = 0.6
		bullet = preload("res://PROJECTILES/Bala2.tscn")
		get_parent().get_node("HUD/Weapon1").add_theme_stylebox_override("panel", wgrad1)
		get_parent().get_node("HUD/Weapon2").add_theme_stylebox_override("panel", wgrad2)
		get_parent().get_node("HUD/Weapon3").add_theme_stylebox_override("panel", wgrad2)
		get_parent().get_node("HUD/Weapon4").add_theme_stylebox_override("panel", wgrad2)
	elif Input.is_action_just_pressed("Weapon2") && shotgun == true:
		weapon = "SHOTGUN"
		fire_rate = 1.25
		bullet = preload("res://PROJECTILES/Bala2.tscn")
		get_parent().get_node("HUD/Weapon1").add_theme_stylebox_override("panel", wgrad2)
		get_parent().get_node("HUD/Weapon2").add_theme_stylebox_override("panel", wgrad1)
		get_parent().get_node("HUD/Weapon3").add_theme_stylebox_override("panel", wgrad2)
		get_parent().get_node("HUD/Weapon4").add_theme_stylebox_override("panel", wgrad2)
	elif Input.is_action_just_pressed("Weapon3") && chaingun == true:
		weapon = "CHAINGUN"
		fire_rate = 0.1
		bullet = preload("res://PROJECTILES/Bala2.tscn")
		get_parent().get_node("HUD/Weapon1").add_theme_stylebox_override("panel", wgrad2)
		get_parent().get_node("HUD/Weapon2").add_theme_stylebox_override("panel", wgrad2)
		get_parent().get_node("HUD/Weapon3").add_theme_stylebox_override("panel", wgrad1)
		get_parent().get_node("HUD/Weapon4").add_theme_stylebox_override("panel", wgrad2)
	elif Input.is_action_just_pressed("Weapon4") && launcher == true:
		weapon = "ROCKET"
		fire_rate = 1.75
		bullet = preload("res://PROJECTILES/Bala2.tscn")
		get_parent().get_node("HUD/Weapon1").add_theme_stylebox_override("panel", wgrad2)
		get_parent().get_node("HUD/Weapon2").add_theme_stylebox_override("panel", wgrad2)
		get_parent().get_node("HUD/Weapon3").add_theme_stylebox_override("panel", wgrad2)
		get_parent().get_node("HUD/Weapon4").add_theme_stylebox_override("panel", wgrad1)

	#Weapon Shooting
	time_since_last_shot += delta
	if ammo > 0:
		if weapon == "PISTOL":
			if Input.is_action_just_pressed("DISPARA") and time_since_last_shot >= fire_rate:
				shoot()
				time_since_last_shot = 0.0
				ammo -= 1
				get_parent().get_node("HUD/Panel2/AmmoText").text = str(ammo)
		elif weapon == "SHOTGUN" && ammo >= 4 :
			if Input.is_action_just_pressed("DISPARA") and time_since_last_shot >= fire_rate:
				var cont = 0
				while cont < 7:
					shoot()
					cont += 1
				time_since_last_shot = 0.0
				ammo -= 4
				cont = 0
				get_parent().get_node("HUD/Panel2/AmmoText").text = str(ammo)
		elif weapon == "CHAINGUN":
			if Input.is_action_pressed("DISPARA") and time_since_last_shot >= fire_rate:
				shoot()
				time_since_last_shot = 0.0
				ammo -= 1
				get_parent().get_node("HUD/Panel2/AmmoText").text = str(ammo)
		elif weapon == "ROCKET" && ammo >= 8:
			if Input.is_action_just_pressed("DISPARA") and time_since_last_shot >= fire_rate:
				shoot()
				time_since_last_shot = 0.0
				ammo -= 8
				get_parent().get_node("HUD/Panel2/AmmoText").text = str(ammo)
	
	#Reloading and Healing
	if canReload:
		if Input.is_action_just_pressed("Reload"):
			if ammo < 400:
				if ammo+reload > 400:
					ammo = 400
				else:
					ammo += reload
				get_parent().get_node("HUD/Panel2/AmmoText").text = str(ammo)
				reloadZone.get_node("CollisionShape2D").set_deferred("disabled", true)
		if Input.is_action_just_pressed("Heal"):
			if health < 200:
				if health+reload > 200:
					health = 200
				else:
					health += reload
				get_parent().get_node("HUD/Panel/HealthText").text = str(health)
				reloadZone.get_node("CollisionShape2D").set_deferred("disabled", true)

func shoot():
	if weapon == "ROCKET":
		var r = rocket.instantiate()
		r.global_position = global_position
		r.direction = global_position.direction_to(get_global_mouse_position())
		get_parent().add_child(r)
	else:
		var b = bullet.instantiate()
		var rngAngle : float
		if weapon == "SHOTGUN":
			rngAngle = rng.randf_range(-0.2, 0.2)
		else:
			rngAngle = rng.randf_range(-0.075, 0.075)
		b.global_position = global_position
		b.direction = global_position.direction_to(get_global_mouse_position()).rotated(rngAngle)
		get_parent().add_child(b)
	


func player_damaged(damage: int):
	health -= damage
	get_parent().get_node("HUD/Panel/HealthText").text = str(health)
	if health <= 0:
		get_parent().get_node("HUD/Panel/HealthText").text = str(0)
		self.queue_free()
