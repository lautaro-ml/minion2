extends "res://state_machine/state.gd"

var box
var player
var horizontal_movement = 0
var early_release = false
var finished = false
var gravity = 98

func connect_box():
	pass

func enter():
	finished = false

func affect(force):
	force.y += gravity *0.01
	return force

func handle_input(_event):
	if (_event.is_action_released("use_telekinesis") or early_release) and !player.is_jumping():
		early_release = false
		var force = (box.get_global_position() - player.get_global_position()).normalized() * 55
		while box.get_slide_count() <= 0 and box.body_below() == null:
			box.move_and_slide(force)
			yield(get_tree().create_timer(0.01), "timeout")
			force = affect(force)
		finished = true

func update(_delta):
	if finished:
		emit_signal("finished", "not_levitating")
