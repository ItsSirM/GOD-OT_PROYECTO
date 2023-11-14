extends CharacterBody2D

var speed = 7.5
var health = 20
var player_chase = false
@onready var player = get_node("/root/GAME/PLAYER")
var targetPosition = 0

func _physics_process(_delta):
	if player_chase:
		targetPosition = (player.position - position).normalized()
		move_and_collide(targetPosition * speed)

func attack():
	var hitbox = player.get_node("Area2D/Hitbox")
	

#Check if player entered enemy sight
func _on_area_2d_body_entered(body):
	if body == player:
		player_chase = true

func _on_area_2d_body_exited(body):
	if body == player:
		player_chase = false
