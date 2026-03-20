extends CharacterBody2D
class_name Player
enum player
{
	RIAN,
	BLIP
}

const SPEED = 6000.0
const DASHSPEED = 5000.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 1100.0
var dashes = 2
var is_rian = true
var is_blip = false
var CAN_MOVE = true
var GRAV_ENABLED = true
var testnum = 2
var IN_CUTSCENE = false
@export var CAMERA:Camera2D
@export var character = player.RIAN

@onready var sprite = $Sprite
@onready var state = $StateMachine
@onready var splash = $Watersplash
@onready var col = $CollisionShape2D
@onready var hurb = $hurtbox
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
	if not is_on_floor() && GRAV_ENABLED:
		velocity.y += GRAVITY * delta
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
	move_and_slide()

func damageHandle(damage):
	Global.p1health -= damage
	state.change_state("Damage")
