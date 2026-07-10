extends Sprite2D








func _ready():
	pass



func _physics_process(_delta):
	var this_ghost = preload("uid://c7xhtl7fh3si7").instantiate()
	get_parent().add_child(this_ghost)
	this_ghost.position = position
	this_ghost.texture = texture
	this_ghost.visible = visible
	this_ghost.scale = scale
	
	
