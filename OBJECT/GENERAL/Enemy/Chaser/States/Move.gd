extends BaseState

var direction = Vector2()
var speed = 100


func _enter(data = {}):
	root.sprite.play("chase")
	
func _step():
	super()
	if Global.player1.position.x < root.position.x:
		root.sprite.flip_h = true
	
	else:
		root.sprite.flip_h = false

	root.velocity = root.position.direction_to(Global.player1.position) * speed



func _exit(next_state):
	super(next_state)
