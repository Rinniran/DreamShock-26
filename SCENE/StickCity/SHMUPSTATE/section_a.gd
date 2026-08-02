extends BaseState

@onready var enemy1 = preload("uid://b00611m0yt6we")
@onready var enemy2 = preload("uid://d0uo2a0xngmbu")

var limiter = Engine.get_frames_per_second()
func _enter(data = {}):
	super()
	
	
func _step():
	super()
	
	match(parent.state_time):
		120:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.global_position = Vector2(331,214)
			e2.global_position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
			print_debug("Spawned!")
		60 * 2:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 3:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 4:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 5:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 6:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)

		60 * 8:
				var e1 = enemy1.instantiate()
				var e2 = enemy1.instantiate()
				
				e1.xspeed = -90
				
				e1.acc = 8
				e2.acc = 4
				
				e1.global_position = Vector2(331,64)
				e2.global_position = Vector2(331,96)
				
				root.add_child(e1)
				root.add_child(e2)
				print_debug("Spawned!")
		60 * 9:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 10:
			
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 11:
			
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 12:
			
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 13:
			
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)
		
		
		
		60 * 15:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.pattern = 1
			e2.pattern = 1
			
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.global_position = Vector2(331,214)
			e2.global_position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
			print_debug("Spawned!")
		60 * 16:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 17:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 18:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 19:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 20:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)

		60 * 22:
				var e1 = enemy1.instantiate()
				var e2 = enemy1.instantiate()
				e1.pattern = 1
				e2.pattern = 1
				e1.xspeed = -90
				
				e1.acc = 8
				e2.acc = 4
				
				e1.global_position = Vector2(331,64)
				e2.global_position = Vector2(331,96)
				
				root.add_child(e1)
				root.add_child(e2)
				print_debug("Spawned!")
		60 * 23:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 24:
			
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 25:
			
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 26:
			
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 27:
			
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			var e3 = enemy2.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e3.pattern = 0
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			e3.global_position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
			root.add_child(e3)
		
		60 * 29:
			var e1 = enemy1.instantiate()
			var e2 = enemy2.instantiate()
			
			e1.pattern = 1
			e2.pattern = 1
			
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.global_position = Vector2(331,214)
			e2.global_position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
			print_debug("Spawned!")
		60 * 30:
			var e1 = enemy2.instantiate()
			var e2 = enemy1.instantiate()
			
			e1.pattern = 1
			e2.pattern = 1
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 31:
			var e1 = enemy1.instantiate()
			var e2 = enemy2.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 32:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 33:
			var e1 = enemy1.instantiate()
			var e2 = enemy2.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 34:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			
			e1.acc = -8
			e2.acc = -4
			
			e1.position = Vector2(331,214)
			e2.position = Vector2(331,180)
			
			root.add_child(e1)
			root.add_child(e2)

		60 * 36:
				var e1 = enemy2.instantiate()
				var e2 = enemy1.instantiate()
				e1.pattern = 1
				e2.pattern = 1
				
				e1.acc = 8
				e2.acc = 4
				
				e1.global_position = Vector2(331,64)
				e2.global_position = Vector2(331,96)
				
				root.add_child(e1)
				root.add_child(e2)
				print_debug("Spawned!")
		60 * 37:
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 38:
			
			var e1 = enemy2.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 39:
			
			var e1 = enemy1.instantiate()
			var e2 = enemy1.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)
		60 * 40:
			
			var e1 = enemy1.instantiate()
			var e2 = enemy2.instantiate()
			e1.pattern = 1
			e2.pattern = 1
			e1.xspeed = -90
			
			e1.acc = 8
			e2.acc = 4
			
			e1.global_position = Vector2(331,64)
			e2.global_position = Vector2(331,96)
			
			root.add_child(e1)
			root.add_child(e2)


func _exit(next_state):
	super(next_state)
