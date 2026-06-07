extends Sprite2D

var mode = "down"


func _physics_process(delta: float) -> void:
	if position.y <= 195:
		mode = "down" 
	
	if position.y >= 200:
		mode = "up" 
	
	
	if mode == "down":
		position.y += 0.25
		
	if mode == "up":
		position.y -= 0.25
