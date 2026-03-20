@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice
var aftimagetimer = 2
var MSPEED = 360


func _enter(data = {}):
	super._enter(data)
	if not root.is_on_floor():
		root.dashes -= 1
	root.sprite.play("dash")
	root.GRAV_ENABLED = false
	root.CAN_MOVE = false
	root.velocity.y = 0


func _step():
	super._step()
	var Kup = Input.is_action_pressed("PAD1_UP")
	var Kdown = Input.is_action_pressed("PAD1_DOWN")
	var Kleft = Input.is_action_pressed("PAD1_LEFT")
	var Kright = Input.is_action_pressed("PAD1_RIGHT")
	var rspr = root.sprite
	
	
	if Kleft and Kup :
		rspr.flip_h = true
		root.velocity.x = -MSPEED
		root.velocity.y = -MSPEED
		rspr.play("ADUpDiag")
	elif Kleft and Kdown:
		rspr.flip_h = true
		root.velocity.x = -MSPEED
		root.velocity.y = MSPEED
		if root.is_on_floor():
			rspr.play("dash")
		else:
			rspr.play("ADDownDiag")
	elif Kleft:
		rspr.flip_h = true
		rspr.flip_h = true
		if root.is_on_floor():
			rspr.play("dash")
		else:
			rspr.play("ADSide")
		root.velocity.x = - MSPEED
		root.velocity.y = 0
	elif Kright and Kup:
		rspr.flip_h = false
		
		rspr.play("ADUpDiag")
		root.velocity.x = MSPEED
		root.velocity.y = -MSPEED
		
	elif Kright and Kdown:
		rspr.flip_h = false
		root.velocity.x = MSPEED
		if root.is_on_floor():
			rspr.play("dash")
		else:
			rspr.play("ADDownDiag")
		root.velocity.y = MSPEED
		
	elif Kright:
		rspr.flip_h = false
		root.velocity.x = MSPEED
		root.velocity.y = 0
		if root.is_on_floor():
			rspr.play("dash")
		else:
			rspr.play("ADSide")
	elif Kup:
		root.velocity.y = -MSPEED
		rspr.play("ADUp")
	elif Kdown:
		root.velocity.y = MSPEED
		rspr.play("ADDown")
	else:
		parent.change_state("Idle")


	
	
	if aftimagetimer > 0:
		aftimagetimer -= 1
	else:
		var aft = preload("res://OBJECT/GENERAL/Afterimage.tscn").instantiate()
		aft.texture = root.sprite.sprite_frames.get_frame_texture(root.sprite.animation, root.sprite.frame)
		aft.flip_h = root.sprite.flip_h
		aft.global_position.x = root.sprite.global_position.x
		aft.global_position.y = root.sprite.global_position.y
		aft.z_index = root.sprite.z_index - 1 
		get_parent().add_child(aft)
		aftimagetimer = 2
	if Input.is_action_just_pressed("PAD1_A"):
		parent.change_state("DashAttack")
	if Input.is_action_just_released("PAD1_C"):
		parent.change_state("Idle")
	if (Input.is_action_just_pressed("PAD1_B") || root.velocity.y < 0) && root.is_on_floor():
		parent.change_state("Jump")
	if parent.state_time >= 25:
		if root.is_on_floor():
			parent.change_state("Idle")
		else:
			parent.change_state("Fall")
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
