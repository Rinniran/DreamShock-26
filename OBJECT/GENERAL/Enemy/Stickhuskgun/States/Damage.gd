extends BaseState

func _enter(data = {}):
	root.anim_can_resume_after_hitstop = false
	root.anim.play("Damage")
	Global.addcombo()
	Global.score += 25 * (Global.chain)
func _step():
	super()
	root.velocity.x = 0
	
	if parent.state_time >= 50:
		parent.change_state("Idle")
	


func _exit(next_state):
	super(next_state)
