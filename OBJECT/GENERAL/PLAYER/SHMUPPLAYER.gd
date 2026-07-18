extends CharacterBody2D
class_name ShmupPlayer

enum wea
{
	NONE
}

@export var speed:int = 8000
@export var level:int = 0
@export var lv2floofA:Node
@export var lv2floofB:Node
@export var lv3floofA:Node
@export var lv3floofB:Node


var shotcool = 0
@onready var sprite = $SPR
@onready var shtsnd = $AudioStreamPlayer

func _ready() -> void:
	Global.player1 = self

func _physics_process(delta: float) -> void:
	
	match(level):
		0:
			lv2floofA.visible = false
			lv2floofB.visible = false
			lv3floofA.visible = false
			lv3floofB.visible = false
		1:
			lv2floofA.visible = true
			lv2floofB.visible = true
			lv3floofA.visible = false
			lv3floofB.visible = false
		2:
			lv2floofA.visible = true
			lv2floofB.visible = true
			lv3floofA.visible = true
			lv3floofB.visible = true
	
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
			shotcool = 6
	
	move_and_slide()
	
	if level > 2:
		level = 2

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
