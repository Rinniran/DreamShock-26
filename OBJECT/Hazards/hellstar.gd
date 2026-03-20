extends CharacterBody2D

@export var speed = 100
@export var jump = 400
@export var gravity = 20

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	velocity.x = -speed
	velocity.y += gravity
	if is_on_floor():
		velocity.y -= jump
	
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	set_physics_process(true)
