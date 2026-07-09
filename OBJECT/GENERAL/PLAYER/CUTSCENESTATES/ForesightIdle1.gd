@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice

func _enter(data = {}):
	super._enter(data)
	root.anim_can_resume_after_hitstop = true
	root.CAN_MOVE = false
	root.GRAV_ENABLED = true
	root.sprite.play("Meh")
	root.vecair = false
	root.velocity.x = 0


func _step():
	super._step()
	
	
	
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = false
	root.GRAV_ENABLED = false
	super._exit(next_state)
