extends BaseState

@onready var bullet = preload("uid://c44c8yipwlhap")
func _enter(data = {}):
	super()
	
	
func _step():
	super()
	
	match(parent.state_time):
		20:
			var pj = bullet.instantiate()
			pj.direction = root.position.direction_to(Global.player1.global_position)
			pj.direction.y = randf_range(-1.0, 1.0)
			pj.position = root.spawnmarker.global_position
			root.get_parent().add_child(pj)
		30:
			var pj = bullet.instantiate()
			pj.direction = root.position.direction_to(Global.player1.global_position)
			pj.direction.y = randf_range(-1.0, 1.0)
			pj.position = root.spawnmarker.global_position
			root.get_parent().add_child(pj)
		80:
			root.swoop = true
	
	


func _exit(next_state):
	super(next_state)
