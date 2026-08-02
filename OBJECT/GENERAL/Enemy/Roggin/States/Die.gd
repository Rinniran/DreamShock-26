@tool
extends BaseState

func _enter(data = {}):
	SoundEngine.playsound(5,root.deathsound.stream, -12)
	Global.hitstopframes = 10
	Global.hitstop = true
	var obj = preload("uid://o3cqd4kts4be").instantiate()
	obj.global_position = root.sprite.global_position 
	get_parent().add_child(obj)
	root.anim_can_resume_after_hitstop = true
	Global.kills += 1
	Global.addcombo()
	Global.score += 25 * (Global.chain)
	root.anim.play("Die")
	root.drop_item()
	pass


func _step():
	super()
	root.global_rotation_degrees = 0
	pass

func _exit(next_state):
	super(next_state)
	pass
