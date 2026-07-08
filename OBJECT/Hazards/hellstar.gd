extends CharacterBody2D

@export var speed = 200
@export var jump = 400
@export var gravity = 20
var activated = false

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	
	var aft = preload("res://OBJECT/GENERAL/Afterimage.tscn").instantiate()
	aft.z_index = z_index - 1 
	aft.texture = $AnimatedSprite2D.sprite_frames.get_frame_texture($AnimatedSprite2D.animation, $AnimatedSprite2D.frame)
	aft.flip_h = $AnimatedSprite2D.flip_h
	aft.global_position = $AnimatedSprite2D.global_position
	
	get_parent().get_parent().add_child(aft)
	
	velocity.x = -speed
	velocity.y += gravity
	if is_on_floor():
		$Clang.play()
		velocity.y -= jump
	
	move_and_slide()
	
	if activated == true && !$VisibleOnScreenNotifier2D.is_on_screen():
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$Watchout.play()
	activated = true
	set_physics_process(true)
