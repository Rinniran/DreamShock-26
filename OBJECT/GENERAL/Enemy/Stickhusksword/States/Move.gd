extends BaseState

func _enter(data = {}):
	super()
	root.anim.play("Die")
	
func _step():
	super()
	root.velocity.x = 0
	root.velocity.y = 0


func _exit(next_state):
	super(next_state)
