extends BaseState

@onready var bullet = preload("uid://c44c8yipwlhap")
func _enter(data = {}):
	super()
	
	
func _step():
	super()
	
	match(parent.state_time):
		60:
			var pj = bullet.instantiate()
			pj.direction = root.position.direction_to(Global.player1.global_position)
			pj.position = root.spawnmarker.global_position
			root.get_parent().add_child(pj)
		80:
			root.swoop = true
	
	


func _exit(next_state):
	super(next_state)
