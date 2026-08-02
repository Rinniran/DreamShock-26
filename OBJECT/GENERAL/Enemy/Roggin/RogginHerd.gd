extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var rotation_speed = 0.5



@onready var roggins = [$Roggin, $Roggin2, $Roggin3, $Roggin4]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_rotation_degrees += rotation_speed
	
#	pass
