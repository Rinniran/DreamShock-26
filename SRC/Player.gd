extends CharacterBody2D
class_name Player2D
enum player
{
	RIAN,
	BLIP
}

enum wea
{
	NONE,
	ODACHI,
	DSLASH,
	SHOTGUN
}

enum pardir
{
	HIGH,
	MID,
	LOW
}

const SPEED: float = 7000.0
const DASHSPEED: float = 5000.0
const JUMP_VELOCITY: float = -400.0
const GRAVITY: float = 1100.0
var anim_can_resume_after_hitstop = false
var dashes: int = 2
var is_rian: bool = true
var is_blip: bool = false
var CAN_MOVE: bool = true
var GRAV_ENABLED: bool = true
var testnum: int = 2
var IN_CUTSCENE: bool = false
var parry_direction = pardir.MID
var parrycool = 0
var paractfr = 0
var parrying = false
var conparries = 0
var iframes = 0
var vecair = false
var DAttacked = false
var isKilled = false


@export var hitstopnull = false
@export var CAMERA:Camera2D
@export var character = player.RIAN
@export var is_3d:bool = false
@export var Dsound:AudioStreamPlayer
@export var dc:AudioStreamPlayer

@onready var sprite = $Sprite
@onready var state = $StateMachine
@onready var splash = $Watersplash
@onready var col = $CollisionShape2D
@onready var hurb = $hurtbox
@onready var hurbcol = $hurtbox/CollisionShape2D
@onready var blood = $BloodPlayer
@onready var inpart = $InvincibleParticle
@onready var white = $CanvasLayer/White
@onready var black = $CanvasLayer/Black
@onready var dcdet = $DownCrushDetect2
@onready var sgr = $Attachments/ShotgunRotary

@onready var damit = $CHit
@onready var aah = $DeathVoice

var dashcoy = 0

func _ready() -> void:
	Global.player1 = self
	state.initialize()

func _physics_process(delta: float) -> void:
	
	if (Global.p1health <= 0 || dcdet.is_colliding() || Global.time <= 0) && isKilled == false:
		state.change_state("Die")
		isKilled = true
	
	# Add the gravity.
	if state.state_name != "Damage" && state.state_name != "Die":
		blood.emitting = false
	
	if Global.invincibility:
		inpart.emitting = true
	else:
		inpart.emitting = false
	
	for hazards in hurb.get_overlapping_areas():
		if state.state_name != "Damage" && state.state_name != "Die" && state.state_name != "DashAttack":
			if hazards.is_in_group("Enemy") || hazards.is_in_group("En_Attack"):
				if !Global.invincibility:
					damageHandle(1)
	if conparries >= 5:
		Global.p1health += 1
		conparries = 0
	if is_on_floor():
		dashes = 2
	if IN_CUTSCENE == false:
		state.advance()
	#print_debug(velocity.x)
	if parrycool > 0: 
		parrycool -= 1
		
	if Input.is_action_just_pressed("PAD1_LEFT") || Input.is_action_just_pressed("PAD1_RIGHT") || Input.is_action_just_pressed("PAD1_UP") || Input.is_action_just_pressed("PAD1_DOWN"):
		if parrycool <= 0:
			parrying = true
		parrycool = 20
	
	if iframes > 0:
		hurbcol.disabled = true
		iframes -= 1
	else:
		hurbcol.disabled = false
	if sprite.animation == "Fjump":
		if Global.hitstop == false:
			if sprite.flip_h == true:
				sprite.rotation_degrees -= 8
			elif sprite.flip_h == false:
				sprite.rotation_degrees += 8
	else:
		sprite.rotation_degrees = 0
	if parrying == true:
		paractfr += 1
		if Input.is_action_pressed("PAD1_LEFT") || Input.is_action_pressed("PAD1_RIGHT"):
			parry_direction = pardir.MID
		
		if Input.is_action_pressed("PAD1_DOWN"):
			parry_direction = pardir.LOW
		
		if Input.is_action_pressed("PAD1_UP"):
			parry_direction = pardir.HIGH
		if Input.is_action_pressed("PAD1_LEFT") || Input.is_action_pressed("PAD1_RIGHT") || Input.is_action_pressed("PAD1_UP") || Input.is_action_pressed("PAD1_DOWN"):
			if paractfr >= 10:
				parrying = false
		if paractfr >= 14:
			parrying = false
	else:
		paractfr = 0
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if vecair == true:
		vectorair(370)
	else:
		DAttacked = false
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction && CAN_MOVE:
			
			velocity.x = direction * SPEED * delta
			if direction < 0:
				sprite.flip_h = true
			elif direction > 0:
				sprite.flip_h = false
		else:
			if CAN_MOVE:
				velocity.x = move_toward(velocity.x, 0, SPEED)
	if CAMERA != null:
		position.x = clamp(position.x,CAMERA.position.x - 150, CAMERA.position.x + 150)
		position.x = clamp(position.x,CAMERA.limit_left + 10, CAMERA.limit_right - 10)
	if !Global.hitstop:
		if not is_on_floor() && GRAV_ENABLED:
			velocity.y += GRAVITY * delta
		state.advance()
		move_and_slide()
		if !sprite.is_playing() && (!sprite.animation_finished || anim_can_resume_after_hitstop):
			sprite.play()
	else:
		if hitstopnull:
			state.advance()
		sprite.stop()
	
	if Global.currweapon == wea.SHOTGUN && !sgr.visible:
		sgr.snd.play()
		sgr.visible = true
	if Global.currweapon == wea.ODACHI:
		sgr.visible = false
		if Input.is_action_just_pressed("PAD1_X"):
			var od = preload("uid://bt4h8nlj2gg6u").instantiate()
			if sprite.flip_h == true:
				od.scale.y = -1
				od.scale.x = -1
			
			add_child(od) 
	
	if dashcoy > 0:
		dashcoy -= 1

func damageHandle(damage):
	var parriedhigh = false
	var parriedmid = false
	var parriedlow = false
	for hazards in $MPBox.get_overlapping_areas():
		if hazards.is_in_group("Enemy") || hazards.is_in_group("En_Attack"):
			if parry_direction == pardir.MID:
				
				parriedmid = true
	for hazards in $HPBox.get_overlapping_areas():
		if hazards.is_in_group("Enemy") || hazards.is_in_group("En_Attack"):
			if parry_direction == pardir.HIGH:
				parriedhigh = true
	for hazards in $LPBox.get_overlapping_areas():
		if hazards.is_in_group("Enemy") || hazards.is_in_group("En_Attack"):
			if parry_direction == pardir.LOW:
				parriedlow = true
	
	if (parriedhigh || parriedlow || parriedmid) && parrying:
		iframes = 40
		Global.hitstopframes = 12
		conparries += 1
		Global.hitstop = true
		if is_on_floor():
			sprite.play("parryground")
		else:
			sprite.play("parryair")
		parrycool = 0
		paractfr = 0
		parrying = false
		var parryobj = preload("uid://ddlo8tdk0vpj0").instantiate()
		parryobj.global_position = global_position
		get_parent().add_child(parryobj)
		var parryspark = preload("uid://o3cqd4kts4be").instantiate()
		parryspark.global_position = global_position
		get_parent().add_child(parryspark)
		Global.time += 5
		Global.chaintime = Global.chaintimereset
		
	else: 
		conparries = 0
		Global.chain = 0
		Global.p1health -= damage
		state.change_state("Damage")

func vectorair(ms):
	
	if velocity.x > ms:
		velocity.x = ms
	elif velocity.x < -ms:
		velocity.x = -ms
	if state.state_name != "Damage" && state.state_name != "Die" && state.state_name != "DashAttack" && state.state_name != "Dash" && state.state_name != "Attack1":
		if sprite.animation != "Fjump":
			sprite.play("Fjump")
	if Input.is_action_pressed("PAD1_LEFT"):
		if velocity.x > 0:
			velocity.x -= 2 * 8
		else:
			velocity.x -= 9
	elif velocity.x < 0:
		velocity.x += 5 
	if Input.is_action_pressed("PAD1_RIGHT"):
		if velocity.x < 0:
			velocity.x += 2 * 8
	elif velocity.x > 0:
		velocity.x += 5 
