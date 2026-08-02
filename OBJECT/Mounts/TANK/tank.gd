extends CharacterBody2D

@export var MOVESPEED = 8000
@export var DASHSPEED = 20000
@export var GRAV = 1000
@export var JSPEED = 500

var MSPEED
var dir = 1
var shotcooldown = 0
var GRAV_ENABLED = true
var MOVE_ENABLED = false
var active = false

var  hp = 10

@onready var state = $StateMachine
@onready var pointer = $Chaingun/Marker2D
@onready var gun = $Chaingun

func _ready() -> void:
	state.initialize()
	print_debug(gun.rotation)


func _physics_process(delta: float) -> void:
	var t = 0.2
	state.advance()
	
	if active: 
		if Input.is_action_just_pressed("PAD1_X"):
			velocity.y = 0
			active = false
		if Global.player1.state.state_name != "LeaveTank":
			Global.player1.state.change_state("MountTank")
		state.change_state("Active")
		Global.player1.position = global_position
		if Input.is_action_pressed("PAD1_A"):
			shoot()
		
		if Input.is_action_pressed("PAD1_C"):
			MSPEED = DASHSPEED
			if !$Dashing.playing:
				$Dashing.play()
		else:
			MSPEED = MOVESPEED
			if $Dashing.playing:
				$Dashing.stop()
	
	if shotcooldown > 0:
		shotcooldown -= 1
	
	if !is_on_floor() && GRAV_ENABLED == true:
		velocity.y += GRAV * delta
	if MOVE_ENABLED:
		if Input.is_action_pressed("PAD1_LEFT") && Input.is_action_pressed("PAD1_UP"):
			gun.rotation = lerp(gun.rotation, -2.04999834280881, t)
			velocity.x = -MSPEED * delta
		elif Input.is_action_pressed("PAD1_LEFT") && Input.is_action_pressed("PAD1_DOWN"):
			gun.rotation = lerp(gun.rotation, 2.04999834280881, t)
			velocity.x = -MSPEED * delta
		elif Input.is_action_pressed("PAD1_LEFT"):
			if MOVE_ENABLED == true:
				dir = -1
				velocity.x = -MSPEED* delta
				gun.rotation = lerp_angle(gun.rotation, -3.13963682808524, t)
				print_debug(deg_to_rad(gun.rotation_degrees))
		elif Input.is_action_pressed("PAD1_RIGHT") && Input.is_action_pressed("PAD1_UP"):
			gun.rotation = lerp(gun.rotation, -0.90999934816093, t)
			velocity.x = MSPEED * delta
		elif Input.is_action_pressed("PAD1_RIGHT") && Input.is_action_pressed("PAD1_DOWN"):
			gun.rotation = lerp(gun.rotation, 0.90999934816093, t)
			velocity.x = MSPEED * delta
		elif Input.is_action_pressed("PAD1_RIGHT"):
			if MOVE_ENABLED == true:
				dir = 1
				velocity.x = MSPEED * delta
				gun.rotation = lerp(gun.rotation, 0.0, t)
		elif Input.is_action_pressed("PAD1_UP"):
			gun.rotation = lerp_angle(gun.rotation,-1.56999871004842, t)
			velocity.x = 0
		elif Input.is_action_pressed("PAD1_DOWN"):
			gun.rotation = lerp(gun.rotation, 1.56999871004842, t)
			velocity.x = 0
		else:
			velocity.x = 0
		
		
		
		
		
		
		
	move_and_slide()
	


func shoot():
	if shotcooldown <= 0:
		var pj = preload("res://OBJECT/Projectiles/Player/TankBullet.tscn").instantiate()
		var rotoffset = randf_range(-0.1, 0.1)
		pj.position = pointer.global_position
		pj.rotation = gun.rotation
		pj.direction = Vector2(1, rotoffset).rotated(pj.rotation)
		get_parent().add_child(pj)
		$Fire.stop()
		$Fire.play()
		shotcooldown = 5


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("En_Attack") && active:
		hp -= 1


func _on_entrybox_body_entered(body: Node2D) -> void:
	if body is Player2D:
		active = true
		
