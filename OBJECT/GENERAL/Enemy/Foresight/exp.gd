extends AnimatedSprite





var sound = AudioStreamPlayer.new()
var snd = preload("res://Audio/SE/ForesightExp1.ogg")


func _ready():
	sound.stream = snd
	add_child(sound)
	pass



func _process(delta):
	if animation == "go" and not sound.is_playing() and is_instance_valid(sound):
		sound.stop()
		sound.play()

