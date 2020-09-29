extends KinematicBody2D

var look_direction = Vector2.RIGHT setget set_look_direction

signal direction_changed(new_direction)

func _ready():
	$use_telekinesis.msh          = $motion_states
	$motion_states/Idle.player    = self
	$motion_states/Walking.player = self
	$motion_states/Jumping.player = self
func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)
