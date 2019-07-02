extends Node2D

var next = false

func _ready():
	pass

func _process(delta):
	
	pass

func _on_Flag_entered(body):
	
	if body.name == "Animal":
		print_debug("youwinmodafuca")
		next = true
	
	pass # Replace with function body.
