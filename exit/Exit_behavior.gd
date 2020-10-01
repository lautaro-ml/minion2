extends Area2D

var player
var can_win = false

func init(target):
	player = target

func _on_Exit_body_entered(body):
	if body == player:
		can_win = true


func _on_Exit_body_exited(body):
	if body == player:
		can_win = false
