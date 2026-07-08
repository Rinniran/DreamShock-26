extends Node2D

var M_Player:AudioStreamPlayer = Global.musicP
@export var MusicVolume = -9.6
@export var Stage_Music:AudioStream
@export var LowTime_Music:AudioStream
@export var stagepath = ""
@onready var Invincible_Music = preload("res://AUDIO/BGM/INVINCIBLE.ogg")
@onready var bossmus = preload("uid://dnwdgnj0j2wap")

@onready var combovoice = [$"100combo", $"200combo", $"300combo", $"400combo"]


func _ready() -> void:
		Global.combovoice = combovoice
		Global.activegame = true
		if M_Player != null && M_Player.stream != null && !M_Player.playing:
			M_Player.play()
		Global.continuepath = stagepath


func _process(delta: float) -> void:
	if M_Player != null:
		M_Player.volume_db = MusicVolume
		if Global.invincibility:
			if M_Player.stream != Invincible_Music:
				M_Player.stream = Invincible_Music
				M_Player.play()
		elif Global.bossactive:
			if M_Player.stream != bossmus:
				M_Player.stream = bossmus
				M_Player.play()
		elif LowTime_Music != null:
			
			if Global.time > 15 && M_Player.stream != bossmus:
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
