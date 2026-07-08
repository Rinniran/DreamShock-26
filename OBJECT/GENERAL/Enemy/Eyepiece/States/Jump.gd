@tool
extends BaseState

func _enter(data = {}):
	

	if Global.player1 != null:
		if Global.player1.position.x < root.position.x and Global.player1.position.x > root.position.x - 500:
			root.sprite.flip_h = false
			root.velocity.x = -150
		
		if Global.player1.position.x > root.position.x and Global.player1.position.x < root.position.x + 500:
			root.sprite.flip_h = true
			root.velocity.x = 150
	
	
	root.anim.play("Jump")
	if root.is_on_floor():
		root.velocity.y -= 300
	pass


func _step():
	super()
	
	if root.velocity.y > 0:
		change_state("Fall")
	
	if root.is_on_floor() && parent.state_time > 25:
		change_state("Idle")
	pass


func _exit(next_state):
	super(next_state)
	pass
