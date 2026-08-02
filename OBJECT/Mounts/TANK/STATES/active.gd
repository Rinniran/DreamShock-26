extends BaseState

func _enter(data = {}):
	super()
	root.MOVE_ENABLED = true
	root.GRAV_ENABLED = true
	
func _step():
	super()
	if !root.active:
		parent.change_state("Unmanned")
	
	if Input.is_action_just_pressed("PAD1_B") && root.is_on_floor():
		root.velocity.y -= root.JSPEED
	
	


func _exit(next_state):
	super(next_state)
