extends BaseState

@onready var snd = $Shot

func _enter(data = {}):
	super()
	root.anim_can_resume_after_hitstop = false
	root.anim.play("Attack")
	root.velocity.x = 0
	
func _step():
	super()
	
	if parent.state_time == 15:
		var pj = preload("res://OBJECT/Projectiles/Enemy/Pellet.tscn").instantiate()
		match(Global.difficulty):
			1:
				pj.speed = pj.speed - 1.5
			2:
				pj.speed -= 1
			4:
				pj.speed += 5
			5:
				pj.speed += 10
		pj.position.y = root.position.y
		pj.direction = root.position.direction_to(Global.player1.global_position)
		pj.own = root
		if root.sprite.flip_h == false:
			pj.direction.x = -1
			pj.position.x = root.position.x - 32
		else:
			pj.direction.x = 1
			pj.position.x = root.position.x + 32
		snd.play()
		get_parent().add_child(pj)
	
	if parent.state_time > 50:
		parent.change_state("Move")
	
	if root.position.distance_to(Global.player1.position) < 10:
		parent.change_state("Attack")
	
	


func _exit(next_state):
	super(next_state)
