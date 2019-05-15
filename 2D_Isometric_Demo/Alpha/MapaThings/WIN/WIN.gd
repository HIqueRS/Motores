extends Node2D

func _ready():
	pass


func _on_Flag_entered(body):
	
	if body.name == "Animal":
		print_debug("youwinmodafuca")
	
	pass # Replace with function body.
