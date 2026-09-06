extends CharacterBody2D

@export_category("Difficulties")
@export var infant = true
@export var human = true
@export var stick = true
@export var adversary = true
@export var dreamshock = true


@export_category("SYSTEM")

@export var hitstopnull = false
@export var hurtstop = 2
@export var can_flinch = false
@export var hp:float = 4
@export var speed: int = 165
@export var unlocks_screen: bool = false
var gravity: int = 25
@export var gravity_enabled: bool = true
@export var extanim:AnimationPlayer
@export var has_damage_state: bool = true
@export var dropped_item:PackedScene
@export var deathsound:AudioStreamPlayer
@export var hurtsound:AudioStreamPlayer
@export var impact_flash:CanvasLayer
@export var anim_can_resume_after_hitstop = true


@onready var state:Node = $StateMachine
@onready var sprite:AnimatedSprite2D = $Sprite2D
@onready var col:CollisionShape2D = $Hurtbox/CollisionShape2D

var dead = false

func _ready() -> void:
	
	
	if Global.difficulty == 1 && !infant:
		queue_free()
	if Global.difficulty == 2 && !human:
		queue_free()
	if Global.difficulty == 3 && !stick:
		queue_free()
	if Global.difficulty == 4 && !infant:
		queue_free()
	if Global.difficulty == 5 && !dreamshock:
		queue_free()
	
	
	match(Global.difficulty):
			1:
				speed -= 50
			2:
				speed -= 25
			4:
				speed += 25
			5:
				speed += 50
	state.initialize()
	set_physics_process(false)
	

func _physics_process(delta: float) -> void:
	if gravity_enabled:
		velocity.y += gravity
	
	
	if !Global.hitstop:
		move_and_slide()
		
		state.advance()
		if !sprite.is_playing() && anim_can_resume_after_hitstop:
			sprite.play()
		if extanim != null:
			if !extanim.is_playing() && (!sprite.animation_finished || anim_can_resume_after_hitstop):
				extanim.play()
	else:
		if hitstopnull:
			state.advance()
		velocity.x = 0
		velocity.y = 0
		sprite.pause()
	if !$VisibleOnScreenNotifier2D.is_on_screen():
		set_physics_process(false)
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	set_physics_process(false)

func drop_item():
	if dropped_item != null:
		var item = dropped_item.instantiate()
		item.global_position = global_position
		get_parent().call_deferred("add_child",item)

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	set_physics_process(true)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pl_Attack") && !dead:
		hp -= area.damage
		if hurtsound != null:
			hurtsound.stop()
			hurtsound.play()
		
		Global.addcombo()
		Global.score += 30 * (Global.chain)
		if hp <= 0:
			if unlocks_screen:
				Global.camera.locked = false
			state.call_deferred("change_state","Die")
			dead = true
		else:
			if area.is_in_group("Heavy"):
				if has_damage_state == true:
					if can_flinch:
						sprite.stop()
						sprite.play()
					#Global.hitstopframes = hurtstop
					#Global.hitstop = true
					state.change_state("Damage")
