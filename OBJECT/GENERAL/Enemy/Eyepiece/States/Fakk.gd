@tool
extends BaseState
var timer = 15
@onready var snd = $Shot

func _enter(data = {}):
	
	if Global.player1 != null:
		if Global.player1.position.x < root.position.x and Global.player1.position.x > root.position.x - 500:
			root.sprite.flip_h = true
			root.speed = - 150
		
		if Global.player1.position.x > root.position.x and Global.player1.position.x < root.position.x + 500:
			root.sprite.flip_h = false
			root.speed = 150
	root.anim.play("Fall")
	
	
	pass


func _step():
	super()
	timer -= 1
	if timer <= 0:
		if is_instance_valid(Global.player1):
			var pj = preload("uid://c44c8yipwlhap").instantiate()
			pj.position.y = root.position.y
			pj.direction = root.position.direction_to(Global.player1.global_position)
			pj.own = root
			if root.sprite.flip_h == false:
				pj.position.x = root.position.x - 16
			else:
				pj.position.x = root.position.x + 16
			snd.play()
			get_parent().add_child(pj)
			timer = 15
	if Global.player1 != null:
		if Global.player1.position.x < root.position.x and Global.player1.position.x > root.position.x - 500:
			root.sprite.flip_h = false
			root.speed = - 150
		
		if Global.player1.position.x > root.position.x and Global.player1.position.x < root.position.x + 500:
			root.sprite.flip_h = true
			root.speed = 150
	
	if root.is_on_floor():
		change_state("Idle")
	pass


func _exit(next_state):
	super(next_state)
	pass
