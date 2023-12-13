class_name Projectile
extends Node2D

@export var speed : int
@export var life : float
@export var damage : int
var direction = Vector2.ZERO
@onready var timer = $Timer
@onready var sprite = $AnimatedSprite2D
@onready var impactD = $ImpactDetector

func _ready():
	set_as_top_level(true)
	look_at(position + direction)
	timer.timeout.connect(self.queue_free)
	timer.start(life)
	impactD.body_entered.connect(self._on_impact)


func _physics_process(delta: float):
	position += direction * speed * delta
	
func _on_impact(_body: Node):
	self.queue_free()
	
func getDamage() -> int:
	return damage
