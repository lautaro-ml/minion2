extends Node

var msh
var target

func _unhandled_input(event):
	if !msh.current_state == msh.jumping:
		if event.is_action_pressed("use_telekinesis") or event.is_action_released("use_telekinesis"):
			handle_input(event)

func handle_input(_event):
	target.handle_input(_event)
