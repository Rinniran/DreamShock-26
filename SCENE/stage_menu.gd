extends Node2D

@export var cursor:Sprite2D
@onready var dflab = $diff
var scenetoreturn = Global.continuepath
var opt = 0
var countdownframes = 200
var chosen = false

var diff = 3

@onready var select = preload("uid://b73vhoh2tttje")
@onready var choose = preload("uid://bjqaodu4q2hqj")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.p1health = 10
	Global.score = 0
	Global.pieces = 0
	Global.activegame = false
	Global.difficulty = diff
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
	Global.difficulty = diff
	
	match(diff):
		1:
			dflab.text = "infant"
			Global.time = 200
			if Input.is_action_just_pressed("PAD1_RIGHT"):
				diff += 1
		2:
			dflab.text = "human"
			Global.time = 120
			if Input.is_action_just_pressed("PAD1_LEFT"):
				diff -= 1
			if Input.is_action_just_pressed("PAD1_RIGHT"):
				diff += 1
		3:
			Global.time = 60
			dflab.text = "stick"
			if Input.is_action_just_pressed("PAD1_LEFT"):
				diff -= 1
			if Input.is_action_just_pressed("PAD1_RIGHT"):
				diff += 1
		4:
			Global.time = 30
			dflab.text = "adversary"
			if Input.is_action_just_pressed("PAD1_LEFT"):
				diff -= 1
			if Input.is_action_just_pressed("PAD1_RIGHT"):
				diff += 1
		5:
			Global.time = 18
			dflab.text = "dreamshock"
			if Input.is_action_just_pressed("PAD1_LEFT"):
				diff -= 1
	
	if !chosen:
		match(opt):
			0:
				scenetoreturn = "uid://b8bifb5oo7aap"
				cursor.position = Vector2(29, 43)
				if Input.is_action_just_pressed("PAD1_DOWN"):
					SoundEngine.playsound(0,select, -10)
					opt = 1
				if Input.is_action_just_pressed("PAD1_B"):
					SoundEngine.playsound(0,choose, -10)
					chosen = true
			1:
				scenetoreturn = "uid://dq6o0n7ir7bos"
				cursor.position = Vector2(29, 67)
				if Input.is_action_just_pressed("PAD1_UP"):
					SoundEngine.playsound(0,select, -10)
					opt = 0
				if Input.is_action_just_pressed("PAD1_DOWN"):
					SoundEngine.playsound(0,select, -10)
					opt = 2
				if Input.is_action_just_pressed("PAD1_B"):
					SoundEngine.playsound(0,choose, -10)
					chosen = true
			2:
				scenetoreturn = "uid://d26lsylndn3gy"
				cursor.position = Vector2(29, 91)
				if Input.is_action_just_pressed("PAD1_UP"):
					SoundEngine.playsound(0,select, -10)
					opt = 1
				if Input.is_action_just_pressed("PAD1_B"):
					SoundEngine.playsound(0,choose, -10)
					chosen = true
	
	if chosen:
		countdownframes -= 1
		if countdownframes <= 0:
			get_tree().change_scene_to_file(scenetoreturn)
