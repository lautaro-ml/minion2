extends Node

var plataform_vector = Vector2.ZERO

# warning-ignore:unused_signal
signal finished(next_state_name)

func enter():
	pass

func name():
	return ""

func exit():
	pass

func handle_input(_event):
	pass

func update(_delta):
	pass

#check if unused
func _on_animation_finished(_anim_name):
	pass
