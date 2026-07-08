@tool
extends Area2D

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


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pl_Attack"):
		$CollisionShape2D.queue_free()
		match(item):
			0:
				Global.invincibile_time = 60 * 16
			1:
				pass
			2:
				pass
			3:
				
				
				if Global.currweapon != Global.player1.wea.SHOTGUN:
					Global.currweapon = Global.player1.wea.SHOTGUN
					Global.ammo =  4
				else:
					Global.ammo += 4
		queue_free()
