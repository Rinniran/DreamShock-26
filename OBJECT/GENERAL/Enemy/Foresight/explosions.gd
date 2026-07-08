extends Node2D


var space = 0


func _ready():
	pass



func _process(delta):
	seq(delta)


func die(whichone:int):
	match whichone:
		1:
			$exp.play("go")
		2:
			$exp2.play("go")
		3:
			$exp3.play("go")
		4:
			$exp4.play("go")
		5:
			$exp5.play("go")
		6:
			$exp6.play("go")
		7:
			$exp7.play("go")
		8:
			$exp8.play("go")
	


func spacetime( time = 0,  do = 0):
	if time > 0:
		time -= 1
	if time <= 0:
		die(do)

func seq(delta):
	spacetime(50, 1)
	spacetime(50, 2)
	spacetime(50, 3)
	spacetime(50, 4)
	spacetime(50, 5)
	spacetime(50, 6)
	spacetime(50, 7)
	spacetime(50, 8)
	
