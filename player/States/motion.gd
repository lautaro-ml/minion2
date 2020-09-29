extends "res://state_machine/state.gd"

onready var player
export (int) var gravity = 1600

func handle_input(event):
	if event.is_action_pressed("jumping"):
		emit_signal("finished", "jumping")

func get_input_direction():
	var input_direction = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
			gravity * 0.0016
	)
	return input_direction

func update_look_direction(direction):
	if direction and player.look_direction != direction:
		player.look_direction = direction
