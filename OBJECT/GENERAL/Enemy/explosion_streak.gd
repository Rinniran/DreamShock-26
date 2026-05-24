extends Node2D
var rng = RandomNumberGenerator.new()
@onready var st = $ExplosionStreak

@export var lifetime = 8

func _ready() -> void:
	
	rng.randomize()
	st.rotation_degrees = rng.randf_range(0,360)

func _physics_process(delta: float) -> void:
	lifetime -= 1
	if lifetime <= 0:
		queue_free()
