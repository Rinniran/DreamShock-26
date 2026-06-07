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
		pj.position.y = root.position.y
		pj.direction.y = randf_range(-0.4,0.4)
		pj.own = root
		if root.sprite.flip_h == false:
			pj.direction.x = -1
			pj.position.x = root.position.x - 48
		else:
			pj.direction.x = 1
			pj.position.x = root.position.x + 48
		snd.play()
		get_parent().add_child(pj)
	
	if parent.state_time > 50:
		parent.change_state("Move")
	
	if root.position.distance_to(Global.player1.position) < 10:
		parent.change_state("Attack")
	
	


func _exit(next_state):
	super(next_state)
