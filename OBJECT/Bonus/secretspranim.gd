extends AnimatedSprite2D





var R = preload("res://OBJECT/Bonus/niceone.tres")


func _ready():
	play("default")
	pass



func _process(_delta):
	var this_ghost = preload("uid://c7xhtl7fh3si7").instantiate()
	get_parent().add_child(this_ghost)
	this_ghost.scale = scale
	this_ghost.position = global_position
	this_ghost.texture = sprite_frames.get_frame_texture(animation, frame)
	this_ghost.visible = visible
	
	
