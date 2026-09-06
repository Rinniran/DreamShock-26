@tool
extends BaseState

@onready var snd = preload("uid://df0u16rdk18q3")

func _enter(data = {}):
	super._enter(data)
	root.CAN_MOVE = true
	root.GRAV_ENABLED = true
	root.anim_can_resume_after_hitstop = false
	
	root.sprite.play("jump")
	if root.is_on_floor():
		SoundEngine.playsound(0, snd, -8)
	if !root.is_3d:
		root.velocity.y = root.JUMP_VELOCITY
	else:
		root.velocity.y = -root.JUMP_VELOCITY


func _step():
	super._step()
	
	if root.is_on_floor() && parent.state_time >= 10:
		if root.velocity.x != 0:
			parent.change_state("Move")
		else:
			parent.change_state("Idle")
	
	if Input.is_action_just_released("PAD1_B"):
		root.velocity.y = 0
	if !root.is_3d:
		if root.velocity.y > 0:
			parent.change_state("Fall")
	else:
		if root.velocity.y < 0:
			parent.change_state("Fall")
	 
	if Input.is_action_just_pressed("PAD1_A"):
		# if root.position.distance_to(Enemy.position) < 5:
		#parent.change_state("throw")
		#if Input.is_action_just_pressed("PAD1_UP"):
			#parent.change_state("Attackup_g")
		#elif Input.is_action_just_pressed("PAD1_DOWN"):
			#parent.change_state("Attackdown_g")
		#else:
		if root.vecair:
			if root.DAttacked == false:
				parent.change_state("DashAttack")
		else:
			if root.dashcoy > 0:
				parent.change_state("DashAttack")
			else:
				parent.change_state("Attack1")
	
	if Input.is_action_just_pressed("PAD1_C") && root.dashes > 0:
		parent.change_state("Dash")
	
	if ((root.wdl.is_colliding() && Input.is_action_pressed("PAD1_LEFT")) || (root.wdr.is_colliding() && Input.is_action_pressed("PAD1_RIGHT"))) && Input.is_action_just_pressed("PAD1_B"):
		if !root.is_on_floor():
			parent.change_state("Walljump")



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
