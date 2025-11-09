@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice

func _enter(data = {}):
	super._enter(data)
	if not root.is_on_floor():
		root.dashes -= 1
	root.anim.play("RianDash")
	root.GRAV_ENABLED = false
	root.CAN_MOVE = false
	root.velocity.y = 0


func _step():
	super._step()
	var aft = preload("res://OBJECT/GENERAL/Afterimage.tscn").instantiate()
	aft.texture = root.sprite.texture
	aft.region_rect = root.sprite.region_rect
	aft.flip_h = root.sprite.flip_h
	aft.global_position.x = root.sprite.global_position.x
	aft.global_position.y = root.sprite.global_position.y
	aft.z_index = root.sprite.z_index - 1 
	root.get_parent().add_child(aft)
	if root.sprite.flip_h == false:
		root.velocity.x = 2000
	if root.sprite.flip_h == true:
		root.velocity.x = -2000
	if parent.state_time >4:
		parent.change_state("Idle")
	
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
