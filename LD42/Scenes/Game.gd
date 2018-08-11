extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (int) var width
export (int) var step
export (String) var paddle_path
var paddle
var lines = []
export (String) var level_path

func _ready():
	var paddle = load (paddle_path)
	var file = File.new ()
	file.open(level_path, file.READ)
	var text = file.get_as_text()
	var result = JSON.parse(text)
	var level = result.result
	file.close()
	if result.error:
		print (result.error_string)
	else:
		if typeof (level) == TYPE_DICTIONARY:
			var d = 0
			var current = [["root", level ["root"]]]
			var new_lines = []
			var positions = {}
			while len (current) != 0:
				var new_current = []
				var paddles = []
				for i in current:
					if typeof (i [1]) == TYPE_DICTIONARY:
						for t in i [1]:
							new_current.append ([t, i[1] [t]])
							new_lines.append ([i [0], t])
					paddles.append(i [0])
				current = new_current
				var n = 0
				for i in paddles:
					var inst = paddle.instance ()
					get_node("/root/Game").call_deferred ("add_child", inst)
					var pos = Vector2 ((n + 1 - float (len (paddles) + 1) / 2) * width, d * step)
					print (i)
					positions [i] = pos
					inst.position = pos
					inst.text (i)
					n += 1
				d += 1
			for i in new_lines:
				lines.append ([positions [i [0]], positions [i [1]]])
				

func _draw ():
	for i in lines:
		draw_line(i [0] + Vector2 (0, 10), i[1], Color (255, 255, 255))

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
