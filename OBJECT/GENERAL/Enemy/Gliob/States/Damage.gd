extends BaseState

func _enter(data = {}):
	root.anim.play("Damage")
	
	Global.addcombo()
	Global.score += 10 * (Global.chain)
func _step():
	super()
	root.velocity.x = 0
	
	if parent.state_time >= 50:
		parent.change_state("Idle")
	


func _exit(next_state):
	super(next_state)
