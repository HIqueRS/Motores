extends Node2D

var next

func _ready():
	pass
	
func _process(delta):
	
	next = get_child(1).next 
	
	pass
