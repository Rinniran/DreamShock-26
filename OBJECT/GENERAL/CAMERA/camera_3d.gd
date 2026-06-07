extends Camera3D

@export var target:Node
@export var speed = 100
@export var locked = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.camera = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	look_at(target.position,Vector3.UP,false)
	if locked == false:
		
		if target.position.x > position.x:
			position.x += speed * delta
			if position.x > target.position.x:
				position.x = target.position.x
		
		if target.position.x < position.x:
			position.x -= speed * delta
			if position.x < target.position.x:
				position.x = target.position.x


	pass
