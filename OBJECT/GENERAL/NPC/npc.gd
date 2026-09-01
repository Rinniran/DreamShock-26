extends Area2D

@export var hud:CanvasLayer

@onready var spr = $SP
@onready var ip = $InteractPrompt
@onready var dia = $Speechbox

func _physics_process(delta: float) -> void:
	if ip.visible == true:
		if Input.is_action_just_pressed("PAD1_UP"):
			dia.visible = true
	if dia.visible:
		Global.camera.target = self
		spr.play("Talk")
		ip.visible = false
		if hud != null:
			hud.visible = false
	else:
		spr.play("Idle")
		if get_tree().paused == false:
			
			Global.camera.target = Global.player1
			if hud != null:
				hud.visible = true


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		ip.visible = true


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		ip.visible = false
