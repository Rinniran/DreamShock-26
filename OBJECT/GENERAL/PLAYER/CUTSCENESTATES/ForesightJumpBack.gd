@tool
extends BaseState

func _enter(data = {}):
	super._enter(data)
	root.CAN_MOVE = false
	root.GRAV_ENABLED = true
	root.anim_can_resume_after_hitstop = false
	root.sprite.play("BJump")
	if !root.is_3d:
		root.velocity.y = root.JUMP_VELOCITY
	else:
		root.velocity.y = -root.JUMP_VELOCITY / 2
		root.velocity.x = -100


func _step():
	super._step()
	root.velocity.x = -100
	if root.is_on_floor() && parent.state_time >= 10:
			parent.change_state("CSIdle2")
	
	
	
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
