extends Node2D

var next
var restart = false

func _ready():
	pass
	
func _process(delta):
	
	next = get_child(1).next 
	
	pass

func restart():
	restart = true
	pass