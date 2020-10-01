extends RigidBody2D

var contra_peso

func _ready():
	add_central_force(Vector2(0, -98))
	#set_linear_velocity(Vector2.ZERO)

func _integrate_forces(state):
	if contra_peso.get_linear_velocity().length() > 1:
		add_central_force(contra_peso.get_linear_velocity() * -1)

func _process(delta):
	#print(str(contra_peso) + str(contra_peso.get_linear_velocity()))
	pass
