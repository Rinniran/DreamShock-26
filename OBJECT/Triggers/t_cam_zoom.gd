extends Area2D

@export var zoom_destination = 0.6
@export var offset_destination = Vector2(0.0,0.0)
@export var c:Camera2D
@onready var t = $Timer
var triggered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") && !triggered:
		var zoomtween = create_tween()
		var offtween = create_tween()
		zoomtween.tween_property(c,"zoom",Vector2(zoom_destination,zoom_destination), 0.6)
		offtween.tween_property(c,"offset",offset_destination, 0.6)
		triggered = true
		#t.start()


func _on_timer_timeout() -> void:
	queue_free()
