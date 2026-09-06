@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice
var aftimagetimer = 2
var MSPEED = 600

var pj = preload("uid://dj8wcp0wqxt1g")

@onready var snd = preload("uid://d0e4667crp6yb")

func _enter(data = {}):
	super._enter(data)
	root.anim_can_resume_after_hitstop = true
	if not root.is_on_floor():
		root.dashes -= 1
	SoundEngine.playsound(0,snd,-2)
	root.sprite.play("waveburst")
	root.GRAV_ENABLED = true
	root.CAN_MOVE = false
	root.velocity.y = 0
	


func _step():
	super._step()
	var Kleft = Input.is_action_pressed("PAD1_LEFT")
	var Kright = Input.is_action_pressed("PAD1_RIGHT")
	var rspr = root.sprite
	
	
	
	
	
	if rspr.flip_h == true && Kleft:
		root.velocity.x = -MSPEED
	elif rspr.flip_h == false && Kright:
		root.velocity.x = MSPEED
	
	else:
		parent.change_state("Idle")
	
	if Input.is_action_just_pressed("PAD1_A"):
		var me = pj.instantiate()
		me.own = root
		me.position.y = 10
		if rspr.flip_h == false:
			me.scale.x = 1
			me.position.x = 24
		else:
			me.scale.x = -1
			me.position.x = -24
		root.add_child(me)
		
	if (Input.is_action_just_pressed("PAD1_B") || root.velocity.y < 0) && root.is_on_floor():
		root.vecair = true
		
		parent.change_state("Jump")
	
	if !root.is_on_floor():
		if ((root.wdl.is_colliding() && Input.is_action_pressed("PAD1_LEFT")) || (root.wdr.is_colliding() && Input.is_action_pressed("PAD1_RIGHT"))) && Input.is_action_just_pressed("PAD1_B"):
			parent.change_state("Walljump")
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
