extends BaseState

func _enter(data = {}):
	super()
	root.anim_can_resume_after_hitstop = true
	root.anim.play("Idle")
	root.velocity.x = 0
	
func _step():
	super()
	if parent.state_time > 25:
		parent.change_state("Move")
	
	if root.global_position.distance_to(Global.player1.global_position) < 10:
		parent.change_state("Attack")
	
	


func _exit(next_state):
	super(next_state)
