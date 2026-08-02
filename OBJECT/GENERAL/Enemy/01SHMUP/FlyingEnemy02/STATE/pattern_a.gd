extends BaseState

@onready var bullet = preload("uid://dvlc3j4pe4pbl")
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
		70:
			var pj = bullet.instantiate()
			pj.direction = root.position.direction_to(Global.player1.global_position)
			pj.position = root.spawnmarker.global_position
			root.get_parent().add_child(pj)
		80:
			var pj = bullet.instantiate()
			pj.direction = root.position.direction_to(Global.player1.global_position)
			root.get_parent().add_child(pj)
		
		100:
			var pj = bullet.instantiate()
			pj.direction = root.position.direction_to(Global.player1.global_position)
			pj.position = root.spawnmarker.global_position
			root.get_parent().add_child(pj)
		130:
			var pj = bullet.instantiate()
			pj.direction = root.position.direction_to(Global.player1.global_position)
			pj.position = root.spawnmarker.global_position
			root.get_parent().add_child(pj)
		150:
			var pj = bullet.instantiate()
			pj.direction = root.position.direction_to(Global.player1.global_position)
			root.get_parent().add_child(pj)
		
		170:
			var pj = bullet.instantiate()
			pj.direction = root.position.direction_to(Global.player1.global_position)
			pj.position = root.spawnmarker.global_position
			root.get_parent().add_child(pj)
		190:
			var pj = bullet.instantiate()
			pj.direction = root.position.direction_to(Global.player1.global_position)
			pj.position = root.spawnmarker.global_position
			root.get_parent().add_child(pj)
		220:
			var pj = bullet.instantiate()
			pj.direction = root.position.direction_to(Global.player1.global_position)
			root.get_parent().add_child(pj)
			
	
	


func _exit(next_state):
	super(next_state)
