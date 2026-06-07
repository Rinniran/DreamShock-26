extends CharacterBody3D
class_name Player3D
enum player
{
	RIAN,
	BLIP
}
enum pardir
{
	HIGH,
	MID,
	LOW
}

const SPEED: float = 40.0
const DASHSPEED: float = 5000.0
const JUMP_VELOCITY: float = -4.0
const GRAVITY: float = -10.0
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
@export var hitstopnull = false
@export var CAMERA:Camera3D
@export var character = player.RIAN
@export var is_3d:bool = true
@export var XLimitLeft = 0
@export var XLimitRight = 8000

@onready var sprite = $Sprite
@onready var state = $StateMachine
@onready var splash = $Watersplash
@onready var col = $CollisionShape3D
@onready var hurb = $hurtbox
@onready var hurbcol = $hurtbox/CollisionShape3D
@onready var blood = $BloodPlayer
@onready var inpart = $InvincibleParticle

func _ready() -> void:
	Global.player1 = self
	state.initialize()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if state.state_name != "Damage" && state.state_name != "Die":
		blood.emitting = false
	
	if Global.invincibility:
		inpart.emitting = true
	else:
		#inpart.emitting = false
		pass
	
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
				sprite.rotation.z += 0.2
			elif sprite.flip_h == false:
				sprite.rotation.z -= 0.2
	else:
		sprite.rotation.z = 0
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
		vectorair(5)
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
	position.x = clamp(position.x,XLimitLeft,XLimitRight)
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
		Global.time += 1
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
			velocity.x -= 1
	if Input.is_action_pressed("PAD1_RIGHT"):
		if velocity.x < 0:
			velocity.x += 2 * 8
		elif velocity.x > 0:
			velocity.x += 1
