extends Marker2D

@export var active = true
@export var bullet_y = 1.0
@export var cooldown = 18

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		if cooldown > 0:
			cooldown -= 1
		if cooldown <= 0:
			var bulleta = preload("uid://c44c8yipwlhap").instantiate()
			bulleta.position = position
			bulleta.direction.x = 0.8
			bulleta.direction.y = bullet_y
			get_parent().add_child(bulleta)
			
			var bulletb = preload("uid://dvlc3j4pe4pbl").instantiate()
			bulletb.position = position
			bulletb.direction.x = 0.8
			bulletb.direction.y = -bullet_y
			get_parent().add_child(bulletb)
			
			cooldown = 18
