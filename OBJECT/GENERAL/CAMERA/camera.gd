extends Camera2D

@export var target:Node
@export var speed = 100
@export var locked = false

enum cam_d
{RIGHT, LEFT, UP, DOWN, UPRIGHT,DOWNRIGHT,UPLEFT,DOWNLEFT}

@export var camdirection = cam_d.RIGHT


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.camera = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if locked == false:
		match(camdirection):
			cam_d.RIGHT:
				if target.position.x > position.x:
					position.x += speed * delta
					if position.x > target.position.x:
						position.x = target.position.x
			cam_d.UPRIGHT:
				if target.position.x > position.x:
					position.x += speed * delta
					if position.x > target.position.x:
						position.x = target.position.x
				if (target.position.y + 8) < position.y:
					position.y -= speed * delta
					if position.y < (target.position.y +8):
						position.y = (target.position.y + 8)
			cam_d.LEFT:
				if target.position.x < position.x:
					position.x -= speed * delta
					if position.x > target.position.x:
						position.x = target.position.x
			cam_d.UP:
				if (target.position.y + 8) < position.y:
					position.y -= speed * delta
					if position.y < target.position.y + 8:
						position.y = target.position.y +8
			cam_d.DOWN:
				if (target.position.y - 8) > position.y:
					position.y += speed * delta
					if position.y + target.position.y - 8:
						position.y = target.position.y - 8
			cam_d.DOWNRIGHT:
				if target.position.x > position.x:
					position.x += speed * delta
					if position.x > target.position.x:
						position.x = target.position.x
				if (target.position.y - 8) > position.y:
					position.y += speed * delta
					if position.y + target.position.y - 8:
						position.y = target.position.y - 8
	pass
