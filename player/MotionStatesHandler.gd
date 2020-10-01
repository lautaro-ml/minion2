extends "res://state_machine/state_machine.gd"

onready var idle    = $Idle
onready var walking = $Walking
onready var jumping = $Jumping

func _ready():
	states_map = {
		"idle"    : idle,
		"walking" : walking,
		"jumping" : jumping,
	}

func init(player):
	for state in states_map.values():
		state.player = player

func update_plataform_vector(force):
	for state in states_map.values():
		state.plataform_vector = force

func stop_plataform_vector():
	for state in states_map.values():
		state.plataform_vector = Vector2.ZERO

func _change_state(state_name):
	if not _active:
		return
	if state_name == "jumping":
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)
