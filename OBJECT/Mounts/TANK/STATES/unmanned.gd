extends BaseState

func _enter(data = {}):
	super()
	root.active = false
	root.MOVE_ENABLED = false
	
func _step():
	super()
	if root.active:
		parent.change_state("Active")
	if Global.player1.state.state_name == "MountTank":
		Global.player1.velocity.x = 0
		Global.player1.velocity.y = 0
		Global.player1.state.change_state("LeaveTank")
	
	


func _exit(next_state):
	super(next_state)
