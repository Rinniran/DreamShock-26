extends Area2D

@export var hud:CanvasLayer

@onready var spr = $SP
@onready var ip = $InteractPrompt
@onready var dia = $Speechbox

func  _ready() -> void:
	dia.dialogue_closed.connect(_on_dialogue_closed)


func _unhandled_input(event: InputEvent) -> void:
	if ip.visible and Input.is_action_just_pressed("PAD1_UP"):
		talk()

func talk():
	dia.visible = true
	Global.camera.target = self
	spr.play("Talk")
	ip.visible = false
	if hud != null:
		hud.visible = false

func _on_dialogue_closed():
	spr.play("Idle")
	Global.camera.target = Global.player1
	if hud != null:
		hud.visible = true

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		ip.visible = true


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		ip.visible = false
