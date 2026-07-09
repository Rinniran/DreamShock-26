@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice
var stopanim = false

func _enter(data = {}):
	super._enter(data)
	root.anim_can_resume_after_hitstop = false
	root.CAN_MOVE = false
	root.GRAV_ENABLED = true
	root.sprite.play("SCIntro")
	root.vecair = false
	root.velocity.x = 0


func _step():
	super._step()
	
	
	if root.sprite.frame == 6:
		stopanim = true
	
	if stopanim == true:
		root.sprite.frame = 6
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = false
	root.GRAV_ENABLED = false
	super._exit(next_state)


func _on_sprite_animation_finished() -> void:
	root.sprite.stop()
