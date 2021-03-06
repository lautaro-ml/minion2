extends "res://player/States/on_ground/on_ground.gd"

export(float) var max_walk_speed = 150

func enter():
	speed = 0.0
	velocity = Vector2()

	var input_direction = get_input_direction()
	update_look_direction(input_direction)


func handle_input(event):
	return .handle_input(event)


func update(_delta):
	var input_direction = get_input_direction()

	if not input_direction:
		emit_signal("finished", "idle")
	update_look_direction(input_direction)

	speed = max_walk_speed
	var collision_info = move(speed, input_direction)
	if not collision_info:
		return


func move(speed, direction):
	velocity = direction.normalized() * speed
	if plataform_vector.y < 0:
		velocity.y = plataform_vector
	else:
		if player.body_below() != null:
			velocity.y = 0
		else:
			velocity.y = gravity
	player.move_and_slide(velocity, Vector2.UP, 5)
	if player.get_slide_count() == 0:
		return
	return player.get_slide_collision(0)
