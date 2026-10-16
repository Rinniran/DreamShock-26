extends BaseState
var snd = preload("res://AUDIO/SE/slash.wav")

func _enter(data = {}):
	root.anim_can_resume_after_hitstop = false
	SoundEngine.playsound(1,snd,4)
	if Global.player1.position.x < root.position.x:
		root.sprite.flip_h = false
	else:
		root.sprite.flip_h = true
	root.anim.play("Attack")
	
func _step():
	super()
	root.velocity.x = 0
	if root.sprite.flip_h == false:
		if root.gdl.is_colliding():
			root.velocity.x = -root.speed - 300
		else:
			root.velocity.x = 0
	else:
		if root.gdr.is_colliding():
			root.velocity.x = root.speed + 300
		else:
			root.velocity.x = 0
	if parent.state_time >= 15:
		parent.change_state("Idle")


func _exit(next_state):
	super(next_state)
