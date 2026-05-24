extends Node
enum weapon
{
	NORMAL,
	FIRE,
	ICE,
	ELEC,
	WATER,
	PLASMA
}

var maxhp: int = 10

var p1lives: int = 2
var p1health: int = maxhp

var p2lives: int = 2
var p21health: int = maxhp

var p1slota: int = weapon.NORMAL
var p1slotb: int = weapon.NORMAL

var p2slota: int = weapon.NORMAL
var p2slotb: int = weapon.NORMAL

var score: int = 0
var activegame:bool = false

var player1: Player = null
var player2: Player = null

var pieces: int = 0

var camera: Camera2D = null

var kills = 0
var killcount = 0
var ms = 0
var tereq = 5

var time = 30

var checkpoint = 0
var timedeathoff = false
var hitstop = false
var hitstopframes = 0

var chain = 0
var chaintimereset = 99
var chaintime = chaintimereset

func _physics_process(delta: float) -> void:
	#if get_tree().get_node_count() > 100:
		#Engine.time_scale = .6
		#ProjectSettings.set_setting("physics_ticks_per_second", 48)
	#else:
		#Engine.time_scale = 0.918
		#ProjectSettings.set_setting("physics_ticks_per_second", 59.18)
	
	if chain > 0:
		if chaintime > 0 && hitstop == false :
			chaintime -= 1
		if chaintime == 0:
			chain = 0
	
	if time > 0 && hitstop == false && activegame == true:
		ms += 1
	if ms >= 60 && !timedeathoff:
		time -= 1
		ms = 0
	if kills >= tereq:
		var te = preload("res://OBJECT/GENERAL/time_ext.tscn").instantiate()
		get_parent().add_child(te)
		kills = 0
	
	
	if hitstopframes > 0:
		hitstopframes -= 1
	if hitstopframes <= 0:
		hitstop = false
	#print_debug(player1.sprite.is_playing())
	pass
