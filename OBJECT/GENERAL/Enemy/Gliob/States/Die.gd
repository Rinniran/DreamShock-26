extends BaseState

func _enter(data = {}):
	root.col.disabled = true
	Global.kills += 1
	Global.chaintime = Global.chaintimereset
	Global.chain += 1
	
	Global.score += 100 * (Global.chain)
	var ex = preload("res://OBJECT/GENERAL/ExplosionA.tscn").instantiate()
	ex.position = root.position
	root.get_parent().add_child(ex)
	root.drop_item()
	root.queue_free()
	
	
func _step():
	super()
	
	



func _exit(next_state):
	super(next_state)
