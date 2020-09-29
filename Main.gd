extends Node2D

func _ready():
	$P1.contra_peso = $P2
	$P2.contra_peso = $P1
