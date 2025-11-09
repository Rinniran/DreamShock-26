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


var p1lives = 2
var p1health = 5

var p2lives = 2
var p21health = 5

var p1slota = weapon.NORMAL
var p1slotb = weapon.NORMAL

var p2slota = weapon.NORMAL
var p2slotb = weapon.NORMAL

var score = 0

var player1 = null
var player2 = null

var camera = null

func _physics_process(delta: float) -> void:
	if get_tree().get_node_count() > 100:
		Engine.time_scale = .6
		ProjectSettings.set_setting("physics_ticks_per_second", 48)
	else:
		Engine.time_scale = 0.918
		ProjectSettings.set_setting("physics_ticks_per_second", 59.18)
