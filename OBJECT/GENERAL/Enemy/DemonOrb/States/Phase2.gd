extends BaseState

func _enter(data = {}):
	root.extanim.play("phase 2")
	
func _step():
	super()
	



func _exit(next_state):
	super(next_state)
