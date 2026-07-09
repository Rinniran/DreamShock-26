extends CharacterBody2D

var jumpspeed = 400
var gravity = 200
var speed = 5
var timer = 10

func _ready() -> void:
	velocity.y -= jumpspeed

func _physics_process(delta: float) -> void:
	velocity.y += gravity
	velocity.x = speed
	move_and_slide()
	if timer > 0:
		timer -= 1
	
	if is_on_floor() && timer == 0:
		var explosion = preload("uid://8ahou6givwnw").instantiate()
		explosion.global_position = global_position
		get_parent().add_child(explosion)
		queue_free()
