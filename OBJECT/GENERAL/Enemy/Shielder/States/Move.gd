extends BaseState

func _enter(data = {}):
	root.gravity_enabled = false
func _step():
	super()
	root.sprite.flip_h = false
	root.velocity.x = -root.speed
	root.velocity.y = 0





func _exit(next_state):
	super(next_state)
