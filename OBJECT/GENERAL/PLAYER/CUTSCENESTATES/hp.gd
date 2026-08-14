extends Area2D
class_name Hp

@export var hp = 1
@onready var col = $collect
var collected = false
var wait = 5
var startwait = false

func _process(delta: float) -> void:
	if has_node("sp"):
		if $sp.animation != "collect":
			$sp.rotation_degrees += 1
	if !col.playing && collected == true:
		queue_free()
	
	if startwait == true:
		if wait > 0:
			wait -= 1
		if wait <= 0:
			collected = true
	
	

func _on_area_entered(area: Area2D) -> void:
	if has_node("sp") && $sp.animation != "collect" && area.is_in_group("Player"):
		
		Global.p1health += hp
		$sp.play("collect")
		col.play()
		
		startwait = true


func _on_sp_animation_finished() -> void:
	if $sp.animation == "collect":
		$sp.queue_free()
