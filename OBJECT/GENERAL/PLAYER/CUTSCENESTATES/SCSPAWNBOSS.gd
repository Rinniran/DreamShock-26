@tool
extends BaseState

@onready var boss = preload("res://OBJECT/GENERAL/Enemy/Foresight/ForeSight.tscn").instantiate()


func _enter(data = {}):
	super._enter(data)
	


func _step():
	super._step()
	
	match (parent.state_time):
		5:
			var tw = create_tween()
			tw.tween_property(root.cam,"offset:x", 0, 0.8)
			boss.position = Vector2(3792.0, -81.0)
			get_parent().add_child(boss)
			
		32:
			root.player.state.change_state("CSJumpBack")
		40:
			$Clang.play()
		42:
			root.cam.offset.y = 5
		44:
			root.cam.offset.y = -5
		46:
			root.cam.offset.y = 5
		48:
			root.cam.offset.y = -5
		50:
			root.cam.offset.y = 5
		52:
			root.cam.offset.y = -5
		54:
			root.cam.offset.y = 0
		142:
			root.subs.visible = true
			$R04.play()
			root.subs.text = "...You're on my shit list now, toots."
		
		260:
			root.subs.visible = false
			boss.detected = true
			Global.activegame = true
			root.player.state.change_state("Idle")
			root.active = false
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	
	super._exit(next_state)
