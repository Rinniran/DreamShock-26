@tool
extends BaseState

func _enter(data = {}):
	
	print_debug("idle")
	root.anim.play("Idle")
	root.velocity.x = 0
	pass


func _step():
	super()
	root.velocity.x = 0
	if parent.state_time > 25:
		change_state("Jump")
	if !root.is_on_floor():
		change_state("Fall")
	pass

func _exit(next_state):
	super(next_state)
	pass
