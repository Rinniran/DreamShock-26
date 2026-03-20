@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice

func _enter(data = {}):
	super._enter(data)
	root.CAN_MOVE = true
	root.GRAV_ENABLED = true
	root.sprite.play("idle")


func _step():
	super._step()
	if root.velocity.x > 0.0 || root.velocity.x < 0.0:
		parent.change_state("Move")
	
	if Input.is_action_just_pressed("PAD1_B") || root.velocity.y < 0:
		parent.change_state("Jump")
	
	if root.velocity.y > 0:
		parent.change_state("Fall") 
	
	if parent.state_time == 200:
		root.sprite.play("WaitA")
	
	if Input.is_action_just_pressed("PAD1_A"):
		# if root.position.distance_to(Enemy.position) < 5:
		#parent.change_state("throw")
		#if Input.is_action_just_pressed("PAD1_UP"):
			#parent.change_state("Attackup_g")
		#elif Input.is_action_just_pressed("PAD1_DOWN"):
			#parent.change_state("Attackdown_g")
		#else:
		parent.change_state("Attack1")
	
	
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)


func _on_sprite_animation_finished() -> void:
	if root.sprite.animation == "WaitA":
		root.sprite.play("WaitB")
