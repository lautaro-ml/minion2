extends Area2D

var player
var can_win = false

func init(target):
	$Label.hide()
	player = target

func _on_Exit_body_entered(body):
	if body == player:
		can_win = true
		$Label.show()


func _on_Exit_body_exited(body):
	if body == player:
		can_win = false
		$Label.hide()
