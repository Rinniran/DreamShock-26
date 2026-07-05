extends Area3D

@export var damage = 1
@export var lifetime = 5
@export var is_projectile = false

@export var own:Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if own != null:
		if own.sprite.flip_h == true:
			scale.x = -1
		else:
			scale.x = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if lifetime > 0:
		lifetime -= 1
	else:
		queue_free()
	
	if own != null && !is_projectile:
		position = own.position
		if own.sprite.flip_h == true:
			scale.x = -1
		else:
			scale.x = 1
