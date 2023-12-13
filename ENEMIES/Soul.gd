class_name Soul
extends Enemy

@onready var timer = $Timer

func _init():
	speed = 800
	health = 100
	damage = 18
	attackRate = 3.5

func _physics_process(_delta):
	null

func _on_area_2d_body_entered(body):
	if body is Player:
		player = body
		timer.timeout.connect(self._dash_to)
		timer.start(attackRate)

func _on_area_2d_body_exited(body):
	if body is Player:
		timer.stop()

func _dash_to():
	targetPosition = (player.position - position).normalized()
	move_and_collide(targetPosition * speed)
