extends BaseState

func _enter(data = {}):
	root.col.disabled = true
	var ex = preload("res://OBJECT/GENERAL/ExplosionA.tscn").instantiate()
	ex.position = root.position
	root.get_parent().add_child(ex)
	root.queue_free()
	
	
func _step():
	super()
	
	



func _exit(next_state):
	super(next_state)
