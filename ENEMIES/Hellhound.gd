extends CharacterBody2D

var speed = 10
var health = 150
var player_chase = false
@export var damage = 22
@export var attackRate = 1.5
@onready var player = get_node("/root/GAME/PLAYER")
var targetPosition = 0

func _physics_process(_delta):
	if player_chase:
		targetPosition = (player.position - position).normalized()
		move_and_collide(targetPosition * speed)
		
func attack():
	return attackRate

func damaged(damage_taken: int):
	health -= damage_taken
	if health <= 0:
		self.queue_free()

func _on_area_2d_body_entered(body):
	if body == player:
		player_chase = true

func _on_area_2d_body_exited(body):
	if body == player:
		player_chase = false
