extends CharacterBody2D






enum wawa{
	IDLE, 
	SHOOT, 
	STOMP, 
	SLIDE, 
	WALK, 
	DIE
}


const SNAPDIR = Vector2.DOWN
var SNAPLEN = 24.0

@export  var states = wawa

@export  var dir = - 1

@export  var detected = false

var idletimer = 0

var rng = RandomNumberGenerator.new()
var choice = rng.randi_range(0, 3)

var motion = Vector2(0, 0)

var snapvec = SNAPDIR * SNAPLEN

var runtimer = 0

var gravity = 500

var Up = Vector2.UP

var hp = 60

var floormax = deg_to_rad(64.0)

var hits = 0

var dashtimer = 0
var shotcooldown = 0

@export  var flip = false

@export var bossmus = preload("uid://dnwdgnj0j2wap")

func _ready():
	states = "IDLE"
	$Health.visible = false
	$Health/ProgressBar.min_value = 0
	$Health/ProgressBar.max_value = 60
	pass



func _physics_process(delta):
	if !is_on_floor():
		velocity.y += 16
	if hp <= 0 and $ForeSight/AnimationPlayer.current_animation != "Die":
		states = "DIE"
		Global.kills += 1
		$Health.visible = false

	position.x = clamp(position.x,Global.camera.position.x - 150, Global.camera.position.x + 150)
	rng.randomize()
	
	$Health/ProgressBar.value = hp
	
	if states != "SLIDE" and states != "DIE":
		match (dir):
			- 1:
				$ForeSight.scale.x = 1
			1:
				$ForeSight.scale.x = - 1
	
	
	
	
	
	if detected and states != "SLIDE" and states != "DIE":
		global_position.x = clamp(global_position.x, Global.camera.global_position.x - 150, Global.camera.global_position.x + 150)
		decision(delta)
		$Health.visible = true
		if Global.player1.global_position.x < global_position.x - 1:
			dir = -1
		if Global.player1.global_position.x > global_position.x + 1:
			dir = 1
			
	
	
	if detected and idletimer > 0:
		idletimer -= 1
		
		
	if idletimer > 0:
		states = "IDLE"
	
	if states == "WALK":
		if runtimer <= 0:
			states = "IDLE"
		else:
			runtimer -= 1
	
	if dashtimer >= 0:
		dashtimer -= 1
	else:
		if states == "SLIDE":
			attack()
	
	match (states):
		"IDLE":
			$ForeSight/AnimationPlayer.play("idle", 0.5)
			velocity.x = 0
			
		"WALK":
			$ForeSight/AnimationPlayer.play("Walk", 0.5)
			velocity.x = 150 * dir
			
		"SLIDE":
			hits = 0
			$ForeSight/AnimationPlayer.play("slide", 0.5)
			velocity.x = 400 * dir
			
		"SHOOT":
			$ForeSight/AnimationPlayer.play("Shoot", 0.5)
			velocity.x = 0
		
		"STOMP":
			$ForeSight/AnimationPlayer.play("Stomp", 0.5)
			velocity.x = 0
		
		"DIE":
			$ForeSight/AnimationPlayer.play("Die", 0.5)
			
			velocity.x = 0
	
	move_and_slide()
	if shotcooldown > 0:
		shotcooldown -= 1
	
	if hp <= 0:
		states = "DIE"
		Global.bossactive = false
	

func stompbombs():
	if shotcooldown == 0:
		var BulletA = preload("uid://dmgnaup40kbf0").instantiate()
		var BulletB = preload("uid://dmgnaup40kbf0").instantiate()
		var BulletC = preload("uid://dmgnaup40kbf0").instantiate()
		
		BulletA.speed = 25 * dir
		BulletB.speed = 75 * dir
		BulletC.speed = 125 * dir
		
		
		
		BulletA.global_position = $ForeSight/LegBack/Legback2/Footback/BombSpawn.global_position
		BulletB.global_position  = $ForeSight/LegBack/Legback2/Footback/BombSpawn.global_position
		BulletC.global_position  = $ForeSight/LegBack/Legback2/Footback/BombSpawn.global_position
		
		get_parent().add_child(BulletA)
		
		get_parent().add_child(BulletB)
		
		get_parent().add_child(BulletC)
		shotcooldown = 20


func shoot():
	if shotcooldown == 0:
		$ForeSight/Spawn.play()
		var BulletA = preload("uid://dkxw3vj0s2u85").instantiate()
		var BulletB = preload("uid://dkxw3vj0s2u85").instantiate()
		var BulletC = preload("uid://dkxw3vj0s2u85").instantiate()
		
		BulletA.start(Transform2D(Vector2(dir, 0), Vector2(0, 1), Vector2(0, 0)))
		BulletB.start(Transform2D(Vector2(dir, 0), Vector2(0, 1), Vector2(0, 0)))
		BulletC.start(Transform2D(Vector2(dir, 0), Vector2(0, 1), Vector2(0, 0)))
		
		
		
		BulletA.global_position = $ForeSight/Head/Shoulderfront/ArmFront/ArmpieceFront/Position2D.global_position + Vector2(0, 15)
		BulletB.global_position  = $ForeSight/Head/Shoulderfront/ArmFront/ArmpieceFront/Position2D.global_position
		BulletC.global_position  = $ForeSight/Head/Shoulderfront/ArmFront/ArmpieceFront/Position2D.global_position + Vector2(0, -15)
		
		get_parent().add_child(BulletA)
		
		get_parent().add_child(BulletB)
		
		get_parent().add_child(BulletC)
		shotcooldown = 20
	

func decision(delta):
	
	if hits >= 20:
		dashtimer = 20
		states = "SLIDE"
		
	if states == "IDLE" and idletimer <= 0:
		choice = rng.randi_range(0, 2)
		match (choice):
			0:
				attack()
			1:
				runtimer = 50
				states = "WALK"

func attack():
	choice = rng.randi_range(0, 1)
	
	match (choice):
		0:
			states = "SHOOT"
		1:
			states = "STOMP"


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Shoot":
		idletimer = 60
		states = "IDLE"
	
	if anim_name == "Stomp":
		idletimer = 60
		states = "IDLE"
		
	if anim_name == "slide":
		idletimer = 60
		states = "IDLE"
		
	if anim_name == "Walk":
		idletimer = 60
		states = "IDLE"


func _on_Hurtbox_area_entered(area):
	if hp > 0:
		
		if area.is_in_group("Pl_Attack"):
			$ForeSight / Head / Conditionplayer.play("damage")
			Global.chaintime = Global.chaintimereset
			Global.chain += 1
			
			hp -= area.damage 
			hits += 1
			
			#var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			#var damobj = damage.instance()
			#damobj.position = global_position
			#damobj.value = str(0.8 + Globals.atkmult)
			#get_parent().add_child(damobj)
			
			Input.start_joy_vibration(0, 1, 1, 0.2)
			$ForeSight / hurt.play()
			var hs = preload("uid://o3cqd4kts4be")
			var ma = hs.instantiate()
			ma.position = global_position
			get_parent().add_child(ma)





	

func _on_multihurt_timeout():
	$multihurtrepeat.stop()
	


func _on_Area2D_area_exited(area):
	$multihurt.stop()




func gonow():
	Global.camera.locked = false

func _on_Conditionplayer_animation_finished(anim_name):
	if anim_name == "damage":
		$ForeSight / Head / Conditionplayer.play("normal")
	pass


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	#detected = true
	Global.bossactive = true
