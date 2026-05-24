extends CharacterBody2D
class_name ShmupPlayer

@export var speed:int = 8000
@export var level:int = 0



func _physics_process(delta: float) -> void:
	if  Input.is_action_pressed("PAD1_LEFT"):
		velocity.x = -speed * delta
	elif  Input.is_action_pressed("PAD1_RIGHT"):
		velocity.x = speed * delta
	else:
		velocity.x = 0
	
	if  Input.is_action_pressed("PAD1_UP"):
		velocity.y = -speed * delta
	elif  Input.is_action_pressed("PAD1_DOWN"):
		velocity.y = speed * delta
	else:
		velocity.y = 0
	
	move_and_slide()
