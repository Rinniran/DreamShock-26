extends CharacterBody2D





var direction = Vector2()
var move = Vector3.ZERO
var speed = 100
var dielol = 0


func _ready():
	pass



func _physics_process(delta):
	
	
	if $Chaser.active and (position.x < Global.camera.limit_left or position.x > Globals.camera.limit_right or position.y < Globals.camera.limit_top or position.y > Globals.camera.limit_bottom):
		queue_free()
	
	if $Chaser.dead == 1:
		
		queue_free()
		
		
	if $Chaser.active and not Globals.incutscene:
		
		if position != Globals.playerpos and not dielol:
			move = position.direction_to(Globals.playerpos) * speed
			move_and_slide(move)
		
		
		if get_slide_count() > 0:
			var collision = get_slide_collision(0)
			if collision != null:
				direction = direction.bounce(collision.normal)
