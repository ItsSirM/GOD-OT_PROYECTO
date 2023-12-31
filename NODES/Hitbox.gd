class_name Hitbox
extends Area2D

@export var cooldown : int
@export var damage : int
@onready var collision_shape := $CollisionShape2D
@onready var timer := $Timer

func _ready():
	if owner is Projectile:
		damage = owner.damage
	elif owner is Enemy:
		damage = owner.damage
		cooldown = owner.attackRate

func _init():
	collision_mask = 0
	collision_layer = 2


func set_disabled(is_disabled: bool):
	collision_shape.set_deferred("disabled", is_disabled)
