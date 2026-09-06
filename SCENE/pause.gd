extends Control

@export var cursor:Sprite2D
var scenetoreturn = Global.continuepath
var opt = 0
var countdownframes = 200
var chosen = false

@onready var select = preload("uid://b73vhoh2tttje")
@onready var choose = preload("uid://bjqaodu4q2hqj")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	
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
			Global.time = 30
		5:
			Global.time = 18
	
	Global.ammo = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !chosen:
		match(opt):
			0:
				
				cursor.position = Vector2(212, 98)
				if Input.is_action_just_pressed("PAD1_DOWN"):
					SoundEngine.playsound(0,select, -10)
					opt = 1
				if Input.is_action_just_pressed("PAD1_B"):
					SoundEngine.playsound(0, choose, -10)
					chosen = true
			1:
				cursor.position = Vector2(212, 114)
				if Input.is_action_just_pressed("PAD1_UP"):
					SoundEngine.playsound(0,select, -10)
					opt = 0
				if Input.is_action_just_pressed("PAD1_DOWN"):
					SoundEngine.playsound(0,select, -10)
					opt = 2
				if Input.is_action_just_pressed("PAD1_B"):
					SoundEngine.playsound(0, choose, -10)
					chosen = true
			2:
				cursor.position = Vector2(212, 131)
				if Input.is_action_just_pressed("PAD1_UP"):
					SoundEngine.playsound(0,select, -10)
					opt = 1
				if Input.is_action_just_pressed("PAD1_B"):
					SoundEngine.playsound(0, choose, -10)
					chosen = true
	
	if chosen:
		match(opt):
			0:
				get_tree().paused = false
				Global.activegame = true
				Global.hud.visible = true
				queue_free()
			1:
				
				countdownframes -= 1
				if countdownframes <= 0:
					get_tree().paused = false
					Global.activegame = true
					Global.hud.visible = true
					Global.bossactive = false
					get_tree().change_scene_to_file(scenetoreturn)
					
			2:
				
				countdownframes -= 1
				if countdownframes <= 0:
					get_tree().paused = false
					Global.bossactive = false
					get_tree().change_scene_to_file("uid://cjdidtrm5d4dy")
		
