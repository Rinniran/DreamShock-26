tool
extends BaseState

func _enter(data = {}):
	._enter()
	root.leaving = true
	root.states = "JUMP"
	root.leavetime = 10
	if Globals.player != null:
		if Globals.player.position.x < root.position.x and Globals.player.position.x > root.position.x - 500:
			root.dir = - 1
			root.speed = - 5200
		
		if Globals.player.position.x > root.position.x and Globals.player.position.x < root.position.x + 500:
			root.dir = 1
			root.speed = 5200
	
	
	if root.is_on_floor():
		root.motion.y -= root.jforce
	pass


func _step():
	._step()
	
	if root.motion.y > 0:
		change_state("Fall")
	
	if root.is_on_floor() && parent.state_time > 25:
		change_state("Idle")
	pass


func _exit(next_state):
	._exit(next_state)
	pass


