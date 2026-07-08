extends Node2D

@export var cursor:Sprite2D
var scenetoreturn = Global.continuepath
var opt = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.p1health = 10
	Global.score = 0
	Global.pieces = 0
	Global.activegame = false
	Global.time = 30
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match(opt):
		0:
			cursor.position = Vector2(19, 197)
			if Input.is_action_just_pressed("PAD1_RIGHT"):
				opt = 1
			if Input.is_action_just_pressed("PAD1_B"):
				get_tree().change_scene_to_file(scenetoreturn)
		1:
			cursor.position = Vector2(194, 197)
			if Input.is_action_just_pressed("PAD1_LEFT"):
				opt = 0
			if Input.is_action_just_pressed("PAD1_B"):
				get_tree().change_scene_to_file("res://SCENE/TITLE.tscn")
	
