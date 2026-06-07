extends BaseState

func _enter(data = {}):
	Global.kills += 1
	root.anim_can_resume_after_hitstop = false
	root.col.disabled = true
	root.extanim.pause()
	root.deathsound.play()
	root.impact_flash.visible = true
	Global.hitstopframes = 80
	Global.hitstop = true
	var obj = preload("uid://o3cqd4kts4be").instantiate()
	obj.global_position = root.sprite.global_position 
	get_parent().add_child(obj)

func create_streak():
	var obj = preload("res://OBJECT/GENERAL/Enemy/ExplosionStreak.tscn").instantiate()
	obj.global_position = root.sprite.global_position
	get_parent().add_child(obj)

func _step():
	super()
	root.extanim.pause()
	match(parent.state_time):
		2:
			root.impact_flash.visible = false
			root.sprite.offset = Vector2(-2,0)
			create_streak()
		4:
			root.sprite.offset = Vector2(2,2)
		6:
			root.impact_flash.visible = true
			root.sprite.offset = Vector2(-2,-2)
		8:
			root.impact_flash.visible = false
			root.sprite.offset = Vector2(2,-2)
			create_streak()
		10:
			root.sprite.offset = Vector2(-2,0)
		12:
			root.sprite.offset = Vector2(2,0)
			create_streak()
		14:
			root.sprite.offset = Vector2(-2,2)
		16:
			root.sprite.offset = Vector2(2,0)
			create_streak()
		22:
			root.sprite.offset = Vector2(0,0)
		79:
			var ex = preload("res://OBJECT/GENERAL/ExplosionA.tscn").instantiate()
			ex.position = root.position
			root.get_parent().add_child(ex)
			root.drop_item()
			root.queue_free()
	
	
	
	



func _exit(next_state):
	super(next_state)
