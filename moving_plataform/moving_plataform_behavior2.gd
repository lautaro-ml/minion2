extends KinematicBody2D

var counter_weight
onready var down_force   = Vector2.ZERO
var can_move_down = true
var is_plataform = true

func _unhandled_input(event):
	if event.is_action_pressed("debug"):
		print(str(get_instance_id()) + ":")
		print("down force: " + str(down_force))
		print("real force: " + str(down_force - counter_weight.down_force))
		pass

func weight():
	return Vector2.ZERO

func init(plataform):
	counter_weight = plataform

func total_weight():
	var bodies = $bodies_above.get_overlapping_bodies()
	var res = Vector2.ZERO
	for body in bodies:
		if body.get_instance_id() != get_instance_id() and body.get_class() == "KinematicBody2D":
			res += body.weight
	return res

func _update_bodies_above():
	if down_force > counter_weight.down_force and can_move_down: counter_weight._move_bodies_above()
	else: counter_weight._stop_move_bodies_above()

func _move_bodies_above():
	var bodies = $bodies_above.get_overlapping_bodies()
	for body in bodies:
		if body.get_class() == "KinematicBody2D" and !body.is_plataform and body.get_instance_id() != get_instance_id():
			body.follow_plataform(down_force - counter_weight.down_force)

func _stop_move_bodies_above():
	var bodies = $bodies_above.get_overlapping_bodies()
	for body in bodies:
		if body.get_class() == "KinematicBody2D" and !body.is_plataform and body.get_instance_id() != get_instance_id():
			body.stop_follow_plataform()

func _physics_process(_delta):
	down_force = total_weight()
	_update_bodies_above()
	if down_force > counter_weight.down_force:
		if can_move_down:
			move_and_slide(down_force - counter_weight.down_force)
	else: if counter_weight.can_move_down:
			move_and_slide(down_force - counter_weight.down_force)

func _on_bodies_below_body_shape_entered(_body_id, body, _body_shape, _area_shape):
	if body.get_instance_id() != get_instance_id():
		can_move_down = false


func _on_bodies_below_body_shape_exited(_body_id, body, _body_shape, _area_shape):
	if body.get_instance_id() != get_instance_id():
		can_move_down = true
