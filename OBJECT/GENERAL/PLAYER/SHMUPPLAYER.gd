extends CharacterBody2D
class_name ShmupPlayer

@export var speed:int = 8000
@export var level:int = 0


var shotcool = 0
@onready var sprite = $SPR
@onready var shtsnd = $AudioStreamPlayer

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
	
	if shotcool > 0:
		shotcool -= 1
	
	if Input.is_action_pressed("PAD1_B"):
		if shotcool <= 0:
			shoot()
			shotcool = 5
	
	move_and_slide()

func shoot():
	shtsnd.stop()
	shtsnd.play()
	var pj1 = preload("res://OBJECT/Projectiles/Player/PR_RiShmup.tscn").instantiate()
	pj1.own = self
	pj1.direction.x = 1
	pj1.position = Vector2(position.x, position.y - 10)
	
	var pj2 = preload("res://OBJECT/Projectiles/Player/PR_RiShmup.tscn").instantiate()
	pj2.own = self
	pj2.direction.x = 1
	pj2.position = Vector2(position.x, position.y + 10)
	
	
	get_parent().add_child(pj1)
	get_parent().add_child(pj2)
