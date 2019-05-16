extends Control

var next

func _ready():
	pass


func _on_Voltar_pressed():
	get_tree().change_scene("res://Alpha/Telas/TelaInicial_teste.tscn")
	pass # Replace with function body.


func _on_Proxima_pressed():
	
	next = true
	print_debug(next)
	
	pass # Replace with function body.
	
func get_next():
	print_debug("ue")
	return next
