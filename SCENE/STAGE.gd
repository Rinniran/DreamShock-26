extends Node2D

@export var M_Player:AudioStreamPlayer
@export var Stage_Music:AudioStream
@export var LowTime_Music:AudioStream


func _ready() -> void:
	M_Player.stream = Stage_Music
	M_Player.play()
	Global.activegame = true


func _process(delta: float) -> void:
	if LowTime_Music != null:
		if Global.time > 15:
			if M_Player.stream != Stage_Music:
				M_Player.stream = Stage_Music
				M_Player.play()
		else:
			if M_Player.stream != LowTime_Music:
				M_Player.stream = LowTime_Music
				M_Player.play()
