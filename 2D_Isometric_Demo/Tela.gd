extends Control

var next = false

func _ready():
	pass


func _on_Voltar_pressed():
	get_tree().change_scene("res://Alpha/Telas/TelaInicial_teste.tscn")
	pass # Replace with function body.


func _on_Proxima_pressed():
	
	next = !next
	
	pass # Replace with function body.
