extends Node2D
var hiding = true

@onready var anm = $AnimationPlayer
@onready var crs = $Cursor

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("PAD1_B"):
		if !anm.is_playing():
			if hiding:
				hiding = false
				anm.play("Aim")
				
			else:
				hiding = true
				anm.play("Hide")
	
	if crs.visible == true:
		if Input.is_action_pressed("PAD1_LEFT"):
			crs.position.x -= 4
		if Input.is_action_pressed("PAD1_RIGHT"):
			crs.position.x += 4
		if Input.is_action_pressed("PAD1_DOWN"):
			crs.position.y += 4
		if Input.is_action_pressed("PAD1_UP"):
			crs.position.y -= 4
