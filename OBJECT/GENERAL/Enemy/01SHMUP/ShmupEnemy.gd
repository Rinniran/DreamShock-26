extends CharacterBody2D
class_name ShmupEnemy



@export var dropped_item:PackedScene
@export var deathsound:AudioStreamPlayer
@export var hurtsound:AudioStreamPlayer
@export var unlocks_screen = false
@export var ScenarioState:StateMachine
@export var swoop = false

@export var hp = 10
var dead = false
@export var xspeed = -50
@export var yspeed = 0
var acc = -5
var pattern = 0
var stateadvanced = false

@onready var iid = preload("res://OBJECT/GENERAL/Itemidentifier.tscn").instantiate()
@onready var sprite = $Sprite
@onready var state = $StateMachine
@onready var spawnmarker = $Marker2D
#The state machine will just control the shots.

func _ready() -> void:
	
	
	state.initialize()
	if dropped_item != null:
		var state = dropped_item.instantiate()
		if state is Capsule:
			if state.item == state.itemselect.ODACHI:
				iid.item = 0
			if state.item == state.itemselect.SHOTGUN:
				iid.item = 1
			if state.item == state.itemselect.DSLASH:
				iid.item = 2
			if state.item == state.itemselect.INVINCIBLE:
				iid.item = 4
		if state is Hp:
			iid.item = 3
		sprite.add_child(iid)
		
		

func _physics_process(delta: float) -> void:
	
	velocity.x = xspeed
	velocity.y = yspeed
	if swoop:
		yspeed += acc
	state.advance()
	if !stateadvanced:
		match (pattern):
			0:
				state.change_state("PatternA")
			1:
				state.change_state("PatternB")
			2:
				state.change_state("PatternC")
			3:
				state.change_state("PatternD")
			4:
				state.change_state("PatternE")
			5:
				state.change_state("PatternF")
		stateadvanced = true
	if !$VisibleOnScreenNotifier2D.is_on_screen():
		queue_free()
		
	move_and_slide()




func drop_item():
	if dropped_item != null:
		var item = dropped_item.instantiate()
		item.global_position = global_position
		get_parent().add_child(item)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pl_Attack") && dead == false:
		hp -= area.damage
		if hurtsound != null:
			hurtsound.stop()
			hurtsound.play()
		
		Global.addcombo()
		Global.score += 30 * (Global.chain)
		if hp <= 0:
			if unlocks_screen:
				Global.camera.locked = false
			#state.change_state("Die")
			#dead = true
			queue_free()
		
