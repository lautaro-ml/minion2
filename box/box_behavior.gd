extends KinematicBody2D

var player
var mouse_in = false

func _ready():
	$State_handler.init(self, player)

func _on_early_release():
	$State_handler.early_release()

func init(target):
	player = target

func follow_plataform(force):
	$State_handler.update_plataform_vector(force)

func stop_follow_plataform():
	$State_handler.stop_plataform_vector()

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

func _on_Box_mouse_entered():
	mouse_in = true

func _on_Box_mouse_exited():
	mouse_in = false
