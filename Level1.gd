extends Node2D

onready var player_template    = preload("res://player/Player.tscn")
onready var box_template       = preload("res://box/box.tscn")
onready var plataform_template = preload("res://moving_plataform/moving_plataform.tscn")
onready var exit_template      = preload("res://exit/Exit.tscn")

onready var player:KinematicBody2D = player_template.instance()

func _ready():
	spawn_exit()
	spawn_player()
	spawn_boxes()
	spawn_plataforms()

func _unhandled_input(event):
	if event.is_action_pressed("win"):
		if $Exit.can_win:
			Global.goto_scene("res://Level 3.tscn")
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()

func spawn_exit():
	var exit:Area2D = exit_template.instance()
	exit.init(player)
	exit.set_position(Vector2(350, -50)) 
	add_child(exit)

func spawn_plataforms():
	var p1:KinematicBody2D = plataform_template.instance()
	var p2:KinematicBody2D = plataform_template.instance()
	p1.init(p2)
	p2.init(p1)
	p1.set_position(Vector2(115, 0)) 
	p2.set_position(Vector2(-400, -17)) 
	add_child(p1)
	add_child(p2)

func spawn_player():
	player.set_position(Vector2(-150, -15)) 
	add_child(player)

func spawn_boxes():
	var box:KinematicBody2D  = box_template.instance()
	var box2:KinematicBody2D = box_template.instance()
	var box3:KinematicBody2D = box_template.instance()
	box.init(player)
	box2.init(player)
	box3.init(player)
	box.set_position(Vector2(115, -100)) 
	box2.set_position(Vector2(-400, -150)) 
	box3.set_position(Vector2(-250, -15)) 
	add_child(box)
	add_child(box2)
	add_child(box3)
