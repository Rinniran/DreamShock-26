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
	root.global_rotation_degrees = 0
	pass

func _exit(next_state):
	super(next_state)
	pass
