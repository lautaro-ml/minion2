extends "res://state_machine/state_machine.gd"

onready var on_ground  = $not_levitating
onready var levitating = $levitating

func early_release():
	levitating.early_release = true

func _ready():
	states_map = {
		"not_levitating"  : on_ground,
		"levitating" : levitating,
	}

func update_plataform_vector(force):
	for state in states_map.values():
		state.plataform_vector = force

func stop_plataform_vector():
	for state in states_map.values():
		state.plataform_vector = Vector2.ZERO

func init(box, player):
	for state in states_map.values():
		state.box = box
		state.player = player
		state.connect_box()
