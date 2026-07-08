@tool
extends BaseState
var timer = 15

func _enter(data = {}):
	if Global.player1 != null:
		if Global.player1.position.x < root.position.x and Globals.player.position.x > root.position.x - 500:
			root.dir = - 1
			root.speed = - 5200
		
		if Globals.player.position.x > root.position.x and Globals.player.position.x < root.position.x + 500:
			root.dir = 1
			root.speed = 5200
	
	pass


func _step():
	super()
	if Global.player1 != null:
		if Global.player1.position.x < root.position.x and Global.player1.position.x > root.position.x - 500:
			root.dir = - 1
			root.speed = - 5200
		
		if Global.player1.position.x > root.position.x and Global.player1.position.x < root.position.x + 500:
			root.dir = 1
			root.speed = 5200
	
	if root.is_on_floor():
		change_state("Idle")
	pass


func _exit(next_state):
	super(next_state)
	pass
