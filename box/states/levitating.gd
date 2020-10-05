extends "res://state_machine/state.gd"

var box
var player
var horizontal_movement = 0
var early_release = false
var finished = false
var began_throw = false
var gravity = 98

func connect_box():
	pass

func enter():
	finished = false
	began_throw = false

func can_launch(_event):
	return (_event.is_action_released("use_telekinesis") or early_release) and !began_throw and !player.is_jumping()

func affect(force):
	force.y += gravity * 0.1
	return force

func handle_input(_event):
	if can_launch(_event):
		began_throw = true
		early_release = false
		var force = (box.get_global_position() - player.get_global_position()).normalized()
		force.y *= 550
		force.x *= 220
		while box.get_slide_count() <= 0 and box.body_below() == null:
			box.move_and_slide(force)
			yield(get_tree().create_timer(0.01), "timeout")
			force = affect(force)
		finished = true

func update(_delta):
	if finished:
		emit_signal("finished", "not_levitating")
