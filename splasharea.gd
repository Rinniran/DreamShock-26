extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for objects in get_overlapping_bodies():
		if objects is Player:
			if objects.is_on_floor():
				objects.splash.visible = true
			elif not objects.is_on_floor() || objects.col.area_exited():
				objects.splash.visible = false
	pass
