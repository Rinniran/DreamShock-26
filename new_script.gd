@tool
extends AnimatedSprite2D
class_name AnimatedPaletteSprite2D

@export_file_path("*.pal") var origin_palette: String
@export var origin_indexes:Array = []

var maxtick = 800
var tick = maxtick

func _process(delta: float) -> void:
	tick -= 1
	if tick <= 0:
		#var mycol = get_line_by_index(palette,4)
		#var colindex = mycol.split(" ")
		#print_debug(colindex[1])
		tick = maxtick
	if origin_palette != "":
		var resizeamount = get_line_by_index(origin_palette,2).to_int()
		origin_indexes.resize(resizeamount)
		for cl in range(origin_indexes.size()):
			var mycol = get_line_by_index(origin_palette,cl + 3)
		
			var colindex = mycol.split(" ")
			var cl_r = colindex[0].to_int()
			var cl_g = colindex[1].to_int()
			var cl_b = colindex[2].to_int()
			if cl == 0:
				origin_indexes[cl] = Color8(cl_r, cl_g, cl_b, 0)
			else:
				origin_indexes[cl] = Color8(cl_r, cl_g, cl_b)
			
		#print_debug(resizeamount)
	elif origin_palette == "":
		origin_indexes.resize(0)

func get_line_by_index(file_path: String, index: int) -> String:
	var content = FileAccess.get_file_as_string(file_path)
	var lines = content.split("\n")
	
	if index >= 0 and index < lines.size():
		return lines[index]
	return ""
