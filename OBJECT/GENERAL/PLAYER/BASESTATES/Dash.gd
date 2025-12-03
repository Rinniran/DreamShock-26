@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice
var aftimagetimer = 2
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
	if aftimagetimer > 0:
		aftimagetimer -= 1
	else:
		var aft = preload("res://OBJECT/GENERAL/Afterimage.tscn").instantiate()
		aft.texture = root.sprite.texture
		aft.region_rect = root.sprite.region_rect
		aft.flip_h = root.sprite.flip_h
		aft.global_position.x = root.sprite.global_position.x
		aft.global_position.y = root.sprite.global_position.y
		aft.z_index = root.sprite.z_index - 1 
		root.get_parent().add_child(aft)
		aftimagetimer = 2
	if root.sprite.flip_h == false:
		root.velocity.x = 600
	if root.sprite.flip_h == true:
		root.velocity.x = -600
	if Input.is_action_just_released("PAD1_C"):
		parent.change_state("Idle")
	if (Input.is_action_just_pressed("PAD1_B") || root.velocity.y < 0) && root.is_on_floor():
		parent.change_state("Jump")
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
