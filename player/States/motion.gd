extends "res://state_machine/state.gd"

onready var player = $"..".player

func handle_input(event):
	if event.is_action_pressed("jump"):
		emit_signal("finished", "jump")

func get_input_direction():
	var input_direction = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
			0
	)
	return input_direction

func update_look_direction(direction):
	if direction and player.look_direction != direction:
		player.look_direction = direction
