extends KinematicBody2D








enum STATES{
	IDLE, 
	JUMP, 
	FALL, 
	LAND, 
	DIE
}

var motion = Vector2(0, 0)

var UP = Vector2.UP

var maxangle = deg2rad(48)

const SNAPDIR = Vector2.DOWN
var SNAPLEN = 24.0


var snapvec = SNAPDIR * SNAPLEN

var gravity = 200

var jforce = 200

var hp = 0.1

var states = states
var deathtimer = 5

var idletimer = 0

var leaving = false

var leavetime = 0

var dir = 1

var speed = 5200

var detected = false

onready var anim = $AnimationPlayer

onready var spr = $Sprite

onready var statemachine = $StateMachine

var cooldown = 0
func _ready():
	
	statemachine.initialize()
	
	pass



func _physics_process(delta):
	global_rotation_degrees = 0
	statemachine.advance()
	if statemachine.get_active_state_name() != "Idle" && statemachine.get_active_state_name() != "Die":
		pass
	if not is_on_floor() and statemachine.get_active_state_name() != "Die":
		pass
	
	if leavetime > 0:
		leavetime -= 1
		
	if idletimer > 0 and is_on_floor():
		idletimer -= 1
	
	if leavetime <= 0:
		leaving = false
	if cooldown > 0:
		cooldown -= 1
	
	if leaving:
		snapvec = Vector2(0, 0)
	else:
		snapvec = SNAPDIR * SNAPLEN
		
	hitHandle()
	if hp <= 0:
		$Hurt/CollisionShape2D.disabled = true
		if deathtimer > 0:
			deathtimer -= 1
		if deathtimer <= 0:
			$CollisionShape2D.disabled = true
		statemachine.change_state("Die")
	
	motion.y = move_and_slide_with_snap(motion, snapvec, UP, true).y



func frameFreeze(timeScale, duration):
	
	
	if hp <= 0:
		var DS = preload("res://Subrooms/Dspark.tscn")
		var buble = DS.instance()
		buble.position = global_position
		get_parent().add_child(buble)
	Globals.canthurt = 1
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0
	Globals.canthurt = 0
	var diesound = preload("res://Audio/SE/Enemdie.wav")
	
	if hp <= 0:
		Globals.score += 40
		states = "DIE"
		Globals.stuntTimer = 30
		if not Globals.stuntList.empty():
			if Globals.player.is_on_floor():
				Globals.stuntList.append("GroundedKill")
			else:
				Globals.stuntList.append("AerialKill")

func _on_Hurt_area_entered(area):
	pass
	
func hitHandle():
	for attacks in $Hurt.get_overlapping_areas():
		
		if states != "DIE" && cooldown <= 0:
			if attacks.is_in_group("hit1"):
				damageHandle(0.8, 0, 1, 15)

				
			if attacks.is_in_group("slash"):
				damageHandle(0.3, 0, 1, 10)
				

			if attacks.is_in_group("enemproject"):
				damageHandle(1.5, 2, 4,15)
				Globals.groovePoints += Globals.grooveWorth * 2
				Globals.grooveTimer = Globals.grooveTimerMax
				Globals.grooveList.append("FriendlyFire")
				Globals.grooveList.pop_front()
				Globals.score += 100
				if hp <= 0:
					Globals.score += 600

				
			if attacks.is_in_group("airhit"):
				damageHandle(0.8, 0, 1, 5)

			if attacks.is_in_group("BIGDAMAGE"):
				damageHandle(3, 2, 1, 15)

func damageHandle(damageval = 0.8, sound = 0, comboadd = 1, cooldownval = 15):
	var organichurt = preload("res://Audio/SE/OrganicHurt.wav")
	var organicNL = preload("res://Audio/SE/OrganicNL.mp3")
	var crit = preload("res://Audio/SE/CRIT.wav")
	Globals.combotimer = 60 * 10
	Globals.combo += comboadd
	
	hp -= damageval
	
	var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
	var damobj = damage.instance()
	damobj.position = position
	damobj.value = str(damageval)
	get_parent().add_child(damobj)
	match(sound):
		0:
			$hurt.stream = organichurt
		1:
			$hurt.stream = organicNL
		2:
			$hurt.stream = crit
	
	$hurt.play()
	Input.start_joy_vibration(0, 1, 1, 0.2)
	$AnimationPlayer.stop(true)
	var hs = preload("res://Subrooms/hitspark.tscn")
	var ma = hs.instance()
	ma.position = position
	get_parent().add_child(ma)
	cooldown = cooldownval
