extends Node2D

onready var player_template = preload("res://player/Player.tscn")
onready var box_template    = preload("res://box/box.tscn")
onready var player:KinematicBody2D = player_template.instance()

func _ready():
	spawn_player()
	spawn_boxes()

func spawn_player():
	player.set_position(Vector2(0, -24.25)) 
	add_child(player)

func spawn_boxes():
	var box:RigidBody2D = box_template.instance()
	box.player = player
	box.set_position(Vector2(-150, -24.25)) 
	add_child(box)
	var box2:RigidBody2D = box_template.instance()
	box2.player = player
	box2.set_position(Vector2(-200, -50)) 
	add_child(box2)
