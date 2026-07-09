extends BaseState

func _enter(data = {}):
	root.extanim.play("phase1", 1)
	
func _step():
	super()
	if root.hp < 10:
		parent.change_state("Phase2")



func _exit(next_state):
	super(next_state)
