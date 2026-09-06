@tool
extends BaseState

var MSPEED = 300
@onready var snd = preload("uid://df0u16rdk18q3")

func _enter(data = {}):
	super._enter(data)
	root.anim_can_resume_after_hitstop = true
	root.CAN_MOVE = false
	root.GRAV_ENABLED = true
	root.sprite.play("BJump")
	root.vecair = false
	root.velocity.y = 0
	root.velocity.y = -500
	SoundEngine.playsound(0, snd, -8)
	


func _step():
	super._step()
	var Kup = Input.is_action_pressed("PAD1_UP")
	var Kdown = Input.is_action_pressed("PAD1_DOWN")
	var Kleft = Input.is_action_pressed("PAD1_LEFT")
	var Kright = Input.is_action_pressed("PAD1_RIGHT")
	if root.sprite.flip_h == false:
		root.velocity.x = -MSPEED
	else:
		root.velocity.x = MSPEED
	if root.is_on_floor():
		parent.change_state("Idle")
	
	if root.wdr.is_colliding() && Input.is_action_just_pressed("PAD1_B"):
		SoundEngine.playsound(0, snd, -8)
		root.velocity.y = 0
		root.velocity.y = -500
		root.velocity.x = -MSPEED
		root.sprite.flip_h = false
	
	if root.wdl.is_colliding() && Input.is_action_just_pressed("PAD1_B"):
		SoundEngine.playsound(0, snd, -8)
		root.velocity.y = 0
		root.velocity.y = -500
		root.velocity.x = -MSPEED
		root.sprite.flip_h = true
	
	if (Kup || Kdown || Kright || Kleft) && Input.is_action_just_pressed("PAD1_C") && root.dashes > 0:
		parent.change_state("Dash")
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)


func _on_sprite_animation_finished() -> void:
	if root.sprite.animation == "WaitA":
		root.sprite.play("WaitB")
