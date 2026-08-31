extends Node2D

@export var cursor:Sprite2D
var scenetoreturn = Global.continuepath
var opt = 0
var countdownframes = 200
var chosen = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.p1health = 10
	Global.score = 0
	Global.pieces = 0
	Global.activegame = false
	match(Global.difficulty):
		1:
			Global.time = 200
		2:
			Global.time = 120
		3:
			Global.time = 60
		4:
			Global.time = 48
		5:
			Global.time = 32
	
	Global.ammo = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !chosen:
		match(opt):
			0:
				scenetoreturn = "uid://b8bifb5oo7aap"
				cursor.position = Vector2(29, 43)
				if Input.is_action_just_pressed("PAD1_DOWN"):
					SoundEngine.playsoundstring(0,"uid://b73vhoh2tttje", -10)
					opt = 1
				if Input.is_action_just_pressed("PAD1_B"):
					SoundEngine.playsoundstring(0,"uid://bjqaodu4q2hqj", -10)
					chosen = true
			1:
				scenetoreturn = "uid://dq6o0n7ir7bos"
				cursor.position = Vector2(29, 67)
				if Input.is_action_just_pressed("PAD1_UP"):
					SoundEngine.playsoundstring(0,"uid://b73vhoh2tttje", -10)
					opt = 0
				if Input.is_action_just_pressed("PAD1_DOWN"):
					SoundEngine.playsoundstring(0,"uid://b73vhoh2tttje", -10)
					opt = 2
				if Input.is_action_just_pressed("PAD1_B"):
					SoundEngine.playsoundstring(0,"uid://bjqaodu4q2hqj", -10)
					chosen = true
			2:
				scenetoreturn = "uid://d26lsylndn3gy"
				cursor.position = Vector2(29, 91)
				if Input.is_action_just_pressed("PAD1_UP"):
					SoundEngine.playsoundstring(0,"uid://b73vhoh2tttje", -10)
					opt = 1
				if Input.is_action_just_pressed("PAD1_B"):
					SoundEngine.playsoundstring(0,"uid://bjqaodu4q2hqj", -10)
					chosen = true
	
	if chosen:
		countdownframes -= 1
		if countdownframes <= 0:
			get_tree().change_scene_to_file(scenetoreturn)
