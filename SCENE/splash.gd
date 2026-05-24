extends Node2D

func _ready() -> void:
	Global.activegame = false

func go_to_title() -> void:
	get_tree().change_scene_to_file("res://SCENE/TITLE.tscn")
