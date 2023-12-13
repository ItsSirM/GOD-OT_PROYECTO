class_name Enemy
extends CharacterBody2D

var speed : float
var health : int
var player_chase : bool
var player
var deathSprite
@export var damage : int
@export var attackRate : float
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

#Check if player entered enemy sight
func _on_area_2d_body_entered(body):
	if body is Player:
		player = body
		player_chase = true

func _on_area_2d_body_exited(body):
	if body is Player:
		player_chase = false
