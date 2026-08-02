extends Area2D






var shot = preload("res://OBJECT/SUBWEAPON/Gunshot.tscn")
@onready var snd = $AudioStreamPlayer

var shtdir = 0


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
	
	
	if (Kleft and Kup) || !Kleft && !Kright && !Kup && !Kdown && shtdir == 1:
		shoti.global_position = $Angle6.global_position
		shoti.rotation_degrees = - 40
		shtdir = 1
		
	elif (Kleft and Kdown) || !Kleft && !Kright && !Kup && !Kdown && shtdir == 2:
		shoti.position = $Angle4.global_position
		shoti.rotation_degrees = - 140
		shtdir = 2
	elif (Kleft) || !Kleft && !Kright && !Kup && !Kdown && shtdir == 3:
		shoti.position = $Angle5.global_position
		shoti.rotation_degrees = - 90
		shtdir = 3
	elif (Kright and Kup) || !Kleft && !Kright && !Kup && !Kdown && shtdir == 4:
		shoti.position = $Angle8.global_position
		shoti.rotation_degrees = 40
		shtdir = 4
	elif (Kright and Kdown) || !Kleft && !Kright && !Kup && !Kdown && shtdir == 5:
		shoti.position = $Angle2.global_position
		shoti.rotation_degrees = 140
		shtdir = 5
	elif (Kright) || !Kleft && !Kright && !Kup && !Kdown && shtdir == 0:
		shoti.position = $Angle.global_position
		shoti.rotation_degrees = 90
		shtdir = 0
	elif (Kup) || !Kleft && !Kright && !Kup && !Kdown && shtdir == 6:
		shoti.position = $Angle7.global_position
		shoti.rotation_degrees = 0
		shtdir = 6
	elif (Kdown) || !Kleft && !Kright && !Kup && !Kdown && shtdir == 7:
		shoti.position = $Angle3.global_position
		shoti.rotation_degrees = 180
		shtdir = 7
	else:
		shoti.position = $Angle.global_position
		shoti.rotation_degrees = 90
		
	
	
	if Input.is_action_just_pressed("PAD1_X") && Global.player1.state.state_name != "MountTank" && Global.player1.state.state_name != "LeaveTank" && visible == true:
		get_parent().add_child(shoti)
	
	global_position = Global.player1.global_position
	if Global.ammo <= 0:
		visible = false
		Global.currweapon = Global.player1.wea.NONE
