extends BaseState

func _enter(data = {}):
	super()
	root.deathsound.play()
	Global.hitstopframes = 10
	Global.hitstop = true
	var obj = preload("uid://o3cqd4kts4be").instantiate()
	obj.global_position = root.sprite.global_position 
	get_parent().add_child(obj)
	root.anim_can_resume_after_hitstop = true
	Global.kills += 1
	Global.addcombo()
	Global.score += 100 * (Global.chain)
	root.anim.play("Die")
	root.drop_item()
	
func _step():
	super()
	root.velocity.x = 0
	root.velocity.y = 0


func _exit(next_state):
	super(next_state)
