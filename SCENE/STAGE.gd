extends Node2D

var M_Player:AudioStreamPlayer = Global.musicP
@export var MusicVolume = -9.6
@export var Stage_Music:AudioStream
@export var LowTime_Music:AudioStream
@export var stagepath = ""
@export var state:StateMachine
@onready var Invincible_Music = preload("res://AUDIO/BGM/INVINCIBLE.ogg")
@onready var bossmus = preload("uid://dnwdgnj0j2wap")

@onready var combovoice = [$"100combo", $"200combo", $"300combo", $"400combo"]

signal levelMusicStart
signal bossMusicStart


func _ready() -> void:
	Global.stage = self
	M_Player = Global.musicP
	M_Player.volume_db = MusicVolume
	Global.invincibility_started.connect(invincibility_music_start)
	Global.invincibility_ended.connect(invincibility_music_stop)
	levelMusicStart.connect(level_music_start)
	bossMusicStart.connect(boss_music_start)
	
	if state != null:
		state.initialize()
	Global.combovoice = combovoice
	Global.activegame = true
	if Global.BGM == true:
		
		if M_Player != null:
			
			if !Global.invincibility:
				if !M_Player.is_playing()|| M_Player.stream != Stage_Music:
					levelMusicStart.emit()
	Global.continuepath = stagepath

func _physics_process(delta: float) -> void:
	if state != null:
		state.advance()



func invincibility_music_start():
	M_Player = Global.musicP
	if M_Player.stream != Invincible_Music:
					M_Player.volume_db = -9
					M_Player.stream = Invincible_Music
					if Global.BGM:
						M_Player.play()

func invincibility_music_stop():
	M_Player = Global.musicP
	M_Player.volume_db = MusicVolume
	if Global.bossactive:
		bossMusicStart.emit()
	else:
		levelMusicStart.emit()

func boss_music_start():
	
	M_Player = Global.musicP
	Global.bossactive = true
	M_Player.stream = bossmus
	if Global.BGM:
		M_Player.play()

func level_music_start():
	M_Player = Global.musicP
	Global.bossactive = false
	if M_Player.stream != Stage_Music:
		M_Player.stream = Stage_Music
	if Global.BGM :
		M_Player.play()
