extends CharacterBody2D
class_name Player
enum player
{
	RIAN,
	BLIP
}

const SPEED: float = 6000.0
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
@export var hitstopnull = false
@export var CAMERA:Camera2D
@export var character = player.RIAN

@onready var sprite = $Sprite
@onready var state = $StateMachine
@onready var splash = $Watersplash
@onready var col = $CollisionShape2D
@onready var hurb = $hurtbox
@onready var hurbcol = $hurtbox/CollisionShape2D
@onready var blood = $BloodPlayer

func _ready() -> void:
	Global.player1 = self
	state.initialize()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if state.state_name != "Damage" && state.state_name != "Die":
		blood.emitting = false
		
	for hazards in hurb.get_overlapping_areas():
		if state.state_name != "Damage" && state.state_name != "Die" && state.state_name != "DashAttack":
			if hazards.is_in_group("Enemy") || hazards.is_in_group("En_Attack"):
				damageHandle(1)
	
	if is_on_floor():
		dashes = 2
	if IN_CUTSCENE == false:
		state.advance()
	#print_debug(velocity.x)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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

func damageHandle(damage):
	Global.p1health -= damage
	state.change_state("Damage")
