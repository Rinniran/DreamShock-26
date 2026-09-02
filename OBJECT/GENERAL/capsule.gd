@tool
extends Area2D
class_name Capsule

enum itemselect{
	INVINCIBLE,
	DSLASH,
	ODACHI,
	SHOTGUN
}
@export var item = itemselect.INVINCIBLE
@onready var spr = $Sprite2D

@onready var sp0 = preload("res://SPRITE/CAPSULE/Invinciblecap.png")
@onready var sp1 = preload("res://SPRITE/CAPSULE/DoubleSlashcap.png")
@onready var sp2 = preload("res://SPRITE/CAPSULE/Odachicap.png")
@onready var sp3 = preload("res://SPRITE/CAPSULE/Shotguncap.png")

var wait = 10


func _physics_process(delta: float) -> void:
	match(item):
		0:
			spr.texture = sp0
		1:
			spr.texture = sp1
		2:
			spr.texture = sp2
		3:
			spr.texture = sp3
	
	if wait > 0:
		wait -= 1


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") && wait == 0:
		$CollisionShape2D.queue_free()
		match(item):
			0:
				Global.invincibile_time = 60 * 24
			1:
				pass
			2:
				if Global.currweapon != Global.player1.wea.ODACHI:
					Global.currweapon = Global.player1.wea.ODACHI
					Global.ammo =  8
				else:
					Global.ammo += 8
			3:
				
				
				if Global.currweapon != Global.player1.wea.SHOTGUN:
					Global.currweapon = Global.player1.wea.SHOTGUN
					Global.ammo =  8
				else:
					Global.ammo += 8
		queue_free()
