extends Control
@export var hp5:Texture2D
@export var hp4:Texture2D
@export var hp3:Texture2D
@export var hp2:Texture2D
@export var hp1:Texture2D
@export var hp0:Texture2D

@onready var hpico = $Life
@onready var pccn = $Piececnt

func _physics_process(delta: float) -> void:
	pccn.text = str(Global.pieces)
	
	match (Global.p1health):
		5:
			hpico.texture = hp5
		4:
			hpico.texture = hp4
		3:
			hpico.texture = hp3
		2:
			hpico.texture = hp2
		1:
			hpico.texture = hp1
		0:
			hpico.texture = hp0
