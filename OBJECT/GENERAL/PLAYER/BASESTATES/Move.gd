@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice

func _enter(data = {}):
	super._enter(data)
	root.CAN_MOVE = true
	root.GRAV_ENABLED = true
	if root.is_on_floor():
			root.anim.play("RianRun")


func _step():
	super._step()
	
	if root.velocity.x == 0:
		parent.change_state("Idle")
	
	if Input.is_action_just_pressed("PAD1_B") || root.velocity.y < 0:
		parent.change_state("Jump")
	
	if root.velocity.y > 0:
		parent.change_state("Fall") 
	
	if Input.is_action_just_pressed("PAD1_A"):
		# if root.position.distance_to(Enemy.position) < 5:
		#parent.change_state("throw")
		if Input.is_action_just_pressed("PAD1_UP"):
			parent.change_state("Attackup_a")
		elif Input.is_action_just_pressed("PAD1_DOWN"):
			parent.change_state("Attackdown_a")
		else:
			parent.change_state("Attackstraight_a")
	
	if Input.is_action_just_pressed("PAD1_C"):
		parent.change_state("Dash")
	
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
