extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var to_load = ""

func load_scene():
	get_tree().change_scene(to_load)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
