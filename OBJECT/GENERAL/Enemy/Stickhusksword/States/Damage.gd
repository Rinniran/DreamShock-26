extends BaseState

func _enter(data = {}):
	root.anim.play("Damage")
	root.anim_can_resume_after_hitstop = false
	Global.addcombo()
	Global.score += 100 * (Global.chain)
func _step():
	super()
	root.velocity.x = 0
	
	if parent.state_time >= 30:
		parent.change_state("Idle")
	


func _exit(next_state):
	super(next_state)
