extends Sprite2D

var framecooldown = 2

var time = 0

@export_multiline() var texts:Array[String] = []

var current_text = 0

@onready var lbl = $Label

func _ready() -> void:
	current_text = 0
	lbl.text = texts[current_text]

func _physics_process(delta: float) -> void:
	if visible == true:
		get_tree().paused = true
		if lbl.visible_characters < lbl.text.length():
			if Input.is_action_just_pressed("PAD1_B"):
				lbl.visible_characters = lbl.text.length()
			if time > 0:
				time -= 1
			else:
				SoundEngine.playsoundstring(0,"uid://d0uuludl0qtb1",-12)
				lbl.visible_characters += 1
				time = framecooldown
		else:
			if Input.is_action_just_pressed("PAD1_B"):
				lbl.visible_characters = 0
				if current_text + 1 < texts.size():
					current_text += 1
					lbl.text = texts[current_text]
				else:
					current_text = 0
					lbl.text = texts[current_text]
					get_tree().paused = false
					visible = false
					
		
