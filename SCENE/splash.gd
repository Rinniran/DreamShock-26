extends Node2D

func _ready() -> void:
	Global.activegame = false



func _on_video_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://SCENE/TITLE.tscn")
