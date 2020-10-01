extends KinematicBody2D

signal push_up(force)
signal push_down(plataform, force)
var counter_weight

var down_forces = Vector2()
var up_forces   = Vector2()

func init(plataform):
	counter_weight = plataform
	connect("push_up", plataform, "_add_up_force")
	connect("push_down", plataform, "_add_down_force")

func _physics_process(_delta):
	_push_down()
	_push_up()

func body_below():
	var space_state = get_world_2d().direct_space_state
	var center = space_state.intersect_ray(position, position + Vector2(0, 5.85), [self])
	var right  = space_state.intersect_ray(position, position + Vector2(12, 5.85), [self])
	var left   = space_state.intersect_ray(position, position + Vector2(-12, 5.85), [self])
	var collider
	var ray_casts = [center, right, left]
	for ray in ray_casts:
		if !ray.empty():
			collider = ray.get("collider")
	return collider

func body_avobe():
	var space_state = get_world_2d().direct_space_state
	var center = space_state.intersect_ray(position, position + Vector2(0, -5.85), [self])
	var right  = space_state.intersect_ray(position, position + Vector2(12, -5.85), [self])
	var left   = space_state.intersect_ray(position, position + Vector2(-12, -5.85), [self])
	var collider
	var ray_casts = [center, right, left]
	for ray in ray_casts:
		if !ray.empty():
			collider = ray.get("collider")
	return collider

func _add_down_force(plataform, force):
	if plataform == self:
		down_forces = force
	
func _add_up_force(force):
	up_forces = force

func _push_down():
	move_and_slide(down_forces)
	emit_signal("push_up", -down_forces)
	if body_below() != null:
		emit_signal("push_down", counter_weight, down_forces)

func _push_up():
	move_and_slide(up_forces)
