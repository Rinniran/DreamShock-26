extends CanvasLayer
@export var hp5:Texture2D
@export var hp4:Texture2D
@export var hp3:Texture2D
@export var hp2:Texture2D
@export var hp1:Texture2D
@export var hp0:Texture2D

@onready var hpico = $Life
@onready var pccn = $Piececnt
@onready var lvcnt = $Label4
@onready var score = $Label2
@onready var timer = $Timer
@onready var hpbar = $Health
@onready var chain = $Chain

func _ready() -> void:
	hpbar.max_value = Global.maxhp

func _physics_process(delta: float) -> void:
	hpbar.value = Global.p1health
	pccn.text = str(Global.pieces)
	lvcnt.text = str(Global.p1lives)
	score.text = str(Global.score)
	timer.text = str(Global.time)
	
	if Global.chain > 0:
		chain.visible = true
	else:
		chain.visible = false
	if Global.p1health > 8:
		hpico.texture = hp5
	elif Global.p1health > 6:
		hpico.texture = hp4
	elif Global.p1health > 4:
		hpico.texture = hp3
	elif Global.p1health > 2:
		hpico.texture = hp2
	elif Global.p1health > 0:
		hpico.texture = hp1
	else:
		hpico.texture = hp0
