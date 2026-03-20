extends CharacterBody2D
@export var hp:float = 4
@export var speed = 165
@export var unlocks_screen = false
var gravity = 25
@export var gravity_enabled = true
@export var extanim:AnimationPlayer
@export var has_damage_state = true


@onready var state = $StateMachine
@onready var sprite = $Sprite2D
@onready var anim = $Sprite2D/AnimationPlayer
@onready var gdl = $Gapdetectleft
@onready var gdr = $Gapdetectright
@onready var col = $Hurtbox/CollisionShape2D

func _ready() -> void:
	state.initialize()

func _physics_process(delta: float) -> void:
	if gravity_enabled:
		velocity.y += gravity
	state.advance()
	move_and_slide()
	if !$VisibleOnScreenNotifier2D.is_on_screen():
		set_physics_process(false)
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	set_physics_process(false)


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	set_physics_process(true)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pl_Attack"):
		hp -= area.damage
		if hp <= 0:
			if unlocks_screen:
				Global.camera.locked = false
			state.change_state("Die")
		else:
			if has_damage_state == true:
				state.change_state("Damage")
