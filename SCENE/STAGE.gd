extends Node2D

var M_Player:AudioStreamPlayer = Global.musicP
@export var MusicVolume = -9.6
@export var Stage_Music:AudioStream
@export var LowTime_Music:AudioStream
@onready var Invincible_Music = preload("res://AUDIO/BGM/INVINCIBLE.ogg")


func _ready() -> void:
		Global.activegame = true


func _process(delta: float) -> void:
	if M_Player != null:
		M_Player.volume_db = MusicVolume
		if Global.invincibility:
			if M_Player.stream != Invincible_Music:
				M_Player.stream = Invincible_Music
				M_Player.play()
		elif LowTime_Music != null:
			
			if Global.time > 15:
				if M_Player.stream != Stage_Music:
					M_Player.stream = Stage_Music
					M_Player.play()
					
			else:
				
				if M_Player.stream != LowTime_Music:
					M_Player.stream = LowTime_Music
					M_Player.play()
		else:
			if M_Player.stream != Stage_Music:
					M_Player.stream = Stage_Music
					M_Player.play()
	else:
		M_Player = Global.musicP
