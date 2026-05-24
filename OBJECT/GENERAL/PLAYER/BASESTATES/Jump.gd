@tool
extends BaseState

func _enter(data = {}):
	super._enter(data)
	root.CAN_MOVE = true
	root.GRAV_ENABLED = true
	root.anim_can_resume_after_hitstop = false
	root.sprite.play("jump")
	root.velocity.y = root.JUMP_VELOCITY


func _step():
	super._step()
	
	if root.is_on_floor() && parent.state_time >= 10:
		if root.velocity.x != 0:
			parent.change_state("Move")
		else:
			parent.change_state("Idle")
	
	if Input.is_action_just_released("PAD1_B"):
		root.velocity.y = 0
	
	if root.velocity.y > 0:
		parent.change_state("Fall")
	 
	if Input.is_action_just_pressed("PAD1_A"):
		# if root.position.distance_to(Enemy.position) < 5:
		#parent.change_state("throw")
		#if Input.is_action_just_pressed("PAD1_UP"):
			#parent.change_state("Attackup_g")
		#elif Input.is_action_just_pressed("PAD1_DOWN"):
			#parent.change_state("Attackdown_g")
		#else:
		parent.change_state("Attack1")
	
	if Input.is_action_just_pressed("PAD1_C") && root.dashes > 0:
		parent.change_state("Dash")
	
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
