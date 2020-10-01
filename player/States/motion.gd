extends "res://state_machine/state.gd"

var player
export (int) var gravity    = 98
export (int) var jump_speed = 0

func get_input_direction():
	var input_direction = Vector2(
			(Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * 100, 
			jump_speed
	)
	return input_direction

func update_look_direction(direction):
	if direction and player.look_direction != direction:
		player.look_direction = direction
