extends "res://state_machine/state.gd"

signal released()

var box
var player
var finished = false
var began_levitating = false
var gravity = 98

func enter():
	finished = false
	began_levitating = false

func connect_box():
# warning-ignore:return_value_discarded
	connect("released", box, "_on_early_release")

func can_levitate(_event):
	return box.mouse_in and _event.is_action_pressed("use_telekinesis") and box.body_below() != null and !player.is_jumping()

func _levitate():
	began_levitating = true
	var force = Vector2(0, -55)
	while force.y < 0:
		box.move_and_slide(force)
		yield(get_tree().create_timer(0.01), "timeout")
		force.y += 1
	finished = true

func handle_input(_event):
	if began_levitating and _event.is_action_released("use_telekinesis"):
		emit_signal("released")
	if can_levitate(_event):
		_levitate()

func update(_delta):
	if !began_levitating:
		if plataform_vector.y < 0:
			box.move_and_slide(plataform_vector)
		else:
			box.move_and_slide(Vector2(0, gravity))
	if finished:
		emit_signal("finished", "levitating")
