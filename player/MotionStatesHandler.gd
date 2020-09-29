extends "res://state_machine/state_machine.gd"

onready var player
onready var idle    = $Idle
onready var walking = $Walking
onready var jumping = $Jumping

func _ready():
	states_map = {
		"idle"    : idle,
		"walking" : walking,
		"jumping" : jumping,
	}

func _change_state(state_name):
	print("debug")
	if not _active:
		return
	if state_name in ["jumping"]:
		states_stack.push_front(states_map[state_name])
	if state_name == ["jumping"] and current_state == walking:
		jumping.initialize(walking.speed, walking.velocity)
	._change_state(state_name)
