extends Node2D

@export var next_scene:PackedScene

func _ready() -> void:
	if is_instance_valid(Global.musicP):
		Global.musicP.stop()
	Global.activegame = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("PAD1_START"):
		get_tree().change_scene_to_packed(next_scene)
