extends "res://player/States/motion.gd"

func enter():
	jump_speed = -165

func update(_delta):
	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	player.move_and_slide(input_direction, Vector2.UP)
	jump_speed += gravity * 0.2
	if player.body_below() != null:
		emit_signal("finished", "previous")
