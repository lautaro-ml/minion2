extends "on_ground.gd"

func handle_input(event):
	return .handle_input(event)

func name():
	return "idle"

func update(_delta):
	var input_direction = get_input_direction()
	if plataform_vector.y < 0:
		player.move_and_slide(plataform_vector, Vector2.UP)
	else:
		player.move_and_slide(Vector2(0,gravity), Vector2.UP)
	if input_direction:
		emit_signal("finished", "walking")
