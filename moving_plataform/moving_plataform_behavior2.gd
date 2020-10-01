extends KinematicBody2D

signal push_up(force)
signal stop()
signal move_up(force)
signal dont_move_up()

var counter_weight
var down_force  = Vector2.ZERO
var total_force
var old_force
var sum_forces

func init(plataform, movable_objs):
	counter_weight = plataform
	# warning-ignore:return_value_discarded
	connect("push_up", plataform, "_add_up_force")
	# warning-ignore:return_value_discarded
	connect("stop", plataform, "_stop")
	for obj in movable_objs:
		connect("move_up", obj, "follow_plataform")
		connect("dont_move_up", obj, "stop_follow_plataform")

func _stop():
	if counter_weight.down_force >= down_force:
		down_force = Vector2.ZERO

func _physics_process(_delta):
	old_force = total_force
	if down_force >= counter_weight.down_force: emit_signal("dont_move_up")
	total_force = move_and_slide(down_force - counter_weight.down_force)
	#print(str(get_instance_id()) + str(down_force) + str(total_force))
	if get_instance_id() == 1272:
		pass
		print(str(get_slide_count()) + str(down_force) + str(get_instance_id()))
	sum_forces = 0
	if get_slide_count() > 0:
		for i in get_slide_count():
			var collition = get_slide_collision(i)
			if collition.collider.get_class() == "KinematicBody2D" and collition.collider.body_below() == self:
				if collition.collider.name == "Player":
					sum_forces += 19.6
				if collition.collider.name == "Box":
					sum_forces += 9.8
				if down_force < counter_weight.down_force:
					emit_signal("move_up", down_force - counter_weight.down_force)
			if collition.collider.get_class() == "StaticBody2D":
				#print(str(counter_weight.down_force))
				emit_signal("stop")
	down_force.y = sum_forces
