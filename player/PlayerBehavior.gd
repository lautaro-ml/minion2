extends KinematicBody2D

var look_direction = Vector2.RIGHT setget set_look_direction
var weight = Vector2(0,19.6)
var is_plataform = false

signal direction_changed(new_direction)

func _unhandled_input(event):
	if event.is_action_pressed("debug"):
		#print(str(get_instance_id()) + ":")
		#print($motion_states.current_state.plataform_vector)
		pass

func follow_plataform(force):
	$motion_states.update_plataform_vector(force)

func stop_follow_plataform():
	$motion_states.stop_plataform_vector()

func _ready():
	$motion_states.init(self)

func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)

func body_below():
	var space_state = get_world_2d().direct_space_state
	var center = space_state.intersect_ray(position, position + Vector2(0, 12), [self])
	var right  = space_state.intersect_ray(position, position + Vector2(11, 12), [self])
	var left   = space_state.intersect_ray(position, position + Vector2(-11, 12), [self])
	var collider
	var ray_casts = [center, right, left]
	for ray in ray_casts:
		if !ray.empty():
			collider = ray.get("collider")
	return collider

func is_jumping():
	return $motion_states.current_state == $motion_states.jumping

