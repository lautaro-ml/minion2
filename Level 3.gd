extends Node2D

onready var box_template = preload("res://box/box.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("win"):
		if $Exit.can_win:
			Global.goto_scene("res://Level 2 and 4.tscn")
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()

func _ready():
	$p1.init($p2)
	$p2.init($p1)
	$Exit.init($Player)
	spawn_boxes()
	
func spawn_boxes():
	var box:KinematicBody2D  = box_template.instance()
	var box2:KinematicBody2D = box_template.instance()
	var box3:KinematicBody2D = box_template.instance()
	box.init($Player)
	box2.init($Player)
	box3.init($Player)
	box.set_position(Vector2(-255, 0)) 
	box2.set_position(Vector2(-100, 160)) 
	box3.set_position(Vector2(-405, 160)) 
	add_child(box)
	add_child(box2)
	add_child(box3)
