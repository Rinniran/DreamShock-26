extends Area2D






var shot = preload("res://OBJECT/SUBWEAPON/Gunshot.tscn")
@onready var snd = $AudioStreamPlayer



func _ready():
	pass



func _process(_delta):
	if Global.currweapon == Global.player1.wea.SHOTGUN && Global.ammo > 0:
		visible = true
	var shoti = shot.instantiate()
	
	var Kleft = Input.is_action_pressed("PAD1_LEFT")
	var Kright = Input.is_action_pressed("PAD1_RIGHT")
	var Kup = Input.is_action_pressed("PAD1_UP")
	var Kdown = Input.is_action_pressed("PAD1_DOWN")
	
	
	if (Kleft and Kup):
		shoti.global_position = $Angle6.global_position
		shoti.rotation_degrees = - 40
	elif Kleft and Kdown:
		shoti.position = $Angle4.global_position
		shoti.rotation_degrees = - 140
	elif Kleft:
		shoti.position = $Angle5.global_position
		shoti.rotation_degrees = - 90
	elif Kright and Kup:
		shoti.position = $Angle8.global_position
		shoti.rotation_degrees = 40
	elif Kright and Kdown:
		shoti.position = $Angle2.global_position
		shoti.rotation_degrees = 140
	elif Kright:
		shoti.position = $Angle.global_position
		shoti.rotation_degrees = 90
	elif Kup:
		shoti.position = $Angle7.global_position
		shoti.rotation_degrees = 0
	elif Kdown:
		shoti.position = $Angle3.global_position
		shoti.rotation_degrees = 180
	else:
		shoti.position = $Angle.global_position
		shoti.rotation_degrees = 90
		
	
	
	if Input.is_action_just_pressed("PAD1_X") && visible == true:
		get_parent().add_child(shoti)
	
	global_position = Global.player1.global_position
	if Global.ammo <= 0:
		visible = false
		Global.currweapon = Global.player1.wea.NONE
