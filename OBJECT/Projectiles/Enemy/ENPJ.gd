extends Area2D

@export var damage = 0.5
@export var lifetime = 12
@export var speed = 10
@export var face_direction = false

@export var own:Node
var direction = Vector2()
var vel = transform.x * speed

@onready var sprite = $AnimatedSprite2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if own != null:
		if own.sprite.flip_h == true:
			scale.x = -1
		else:
			scale.x = 1
	vel = (direction * speed) * scale.x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if face_direction:
		sprite.rotation = vel.angle()
	if !Global.hitstop:
		position += direction * speed
	
	if lifetime > 0:
		lifetime -= 1
	else:
		queue_free()
	


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		queue_free()
