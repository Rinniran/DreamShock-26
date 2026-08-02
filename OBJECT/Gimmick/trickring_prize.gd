extends Node2D

@export var prize:PackedScene

var active = false
var rings = []

var prizegiven = false

var win = false
var lose = false

var soundplayed = false

func _ready() -> void:
	for children in get_children():
		if children is TrickRing:
			if !rings.has(children):
				rings.append(children)
			print_debug(rings)


func _physics_process(delta: float) -> void:
	
	if active && Global.player1.is_on_floor() && win == false:
		lose = true
		for child in get_children():
			if child is not AudioStreamPlayer:
				child.queue_free()
		if !$Fail.playing:
			if soundplayed == false:
				$Fail.play()
				soundplayed = true
	
	if active && rings == [] && !Global.player1.is_on_floor() && lose == false:
		win = true
		
			
		if !prizegiven:
			if !$Win.playing:
				$Win.play()
			var p = prize.instantiate()
			if is_instance_valid(p):
				p.position = $PrizeSpawn.global_position
				get_parent().add_child(p)
				prizegiven = true


func _on_win_finished() -> void:
	queue_free()


func _on_fail_finished() -> void:
	queue_free()
