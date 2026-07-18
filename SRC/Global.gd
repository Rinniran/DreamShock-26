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

var ammo = 0

var score: int = 0
var activegame:bool = false

var player1: Node = null
var player2: Node = null

var pieces: int = 0

var camera: Node = null

var kills = 0
var killcount = 0
var ms = 0
var tereq = 8

var time = 60

var checkpoint = 0
var timedeathoff = false
var hitstop = false
var hitstopframes = 0

var invincibile_time = 0
var invincibility = false

var chain = 0
var chaintimereset = 99
var chaintime = chaintimereset
var combovoice
var currweapon = null

var continuepath = ""
var bossactive = false

@onready var musicP = AudioStreamPlayer.new()

signal counted

func _ready() -> void:
	add_child(musicP)

func _physics_process(delta: float) -> void:
	#if get_tree().get_node_count() > 100:
		#Engine.time_scale = .6
		#ProjectSettings.set_setting("physics_ticks_per_second", 48)
	#else:
		#Engine.time_scale = 0.918
		#ProjectSettings.set_setting("physics_ticks_per_second", 59.18)
	
	if is_instance_valid(player1):
		if currweapon == null:
			currweapon = player1.wea.NONE
	
	if p1health > maxhp:
		p1health = maxhp
	
	
	if chain > 0:
		if chaintime > 0 && hitstop == false :
			chaintime -= 1
		if chaintime == 0:
			chain = 0
	
	if time > 0 && hitstop == false && activegame == true:
		if player1 != null && player1.velocity.x == 0:
			ms += 0.5
		else:
			ms += 1
	if ms >= 60 && !timedeathoff:
		time -= 1
		ms = 0
		counted.emit()
	if kills >= tereq:
		var te = preload("res://OBJECT/GENERAL/time_ext.tscn").instantiate()
		get_parent().add_child(te)
		kills = 0
	
	if invincibile_time > 0:
		invincibility = true
		invincibile_time -= 1
	else:
		invincibility = false
	
	if hitstopframes > 0:
		hitstopframes -= 1
	if hitstopframes <= 0:
		hitstop = false
	#print_debug(player1.sprite.is_playing())
	pass

func addcombo():
	Global.chaintime = Global.chaintimereset
	Global.chain += 1
	match(chain):
		100:
			Global.combovoice[0].play()
		200:
			Global.combovoice[1].play()
		300:
			Global.combovoice[2].play()
		400:
			Global.combovoice[3].play()
