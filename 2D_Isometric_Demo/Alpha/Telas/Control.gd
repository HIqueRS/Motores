extends Control

func _ready():
	pass

func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Alpha/Fases/Fase_Base.tscn")
		pass
	
	pass



func _on_Instrucoes_pressed():
	
	get_tree().change_scene("res://Alpha/Telas/Instrucoes.tscn")
	
	pass 


func _on_Novo_jogo_pressed():
	
	get_tree().change_scene("res://Alpha/Fases/Fase_Base.tscn")
	
	pass # Replace with function body.


func _on_Opcoes_pressed():
	
	get_tree().change_scene("res://Alpha/Telas/Opcoes.tscn")
	
	pass # Replace with function body.


func _on_Creditos_pressed():
	
	get_tree().change_scene("res://Alpha/Telas/Creditos.tscn")
	
	pass # Replace with function body.


func _on_Sair_pressed():
	
	get_tree().quit()
	
	pass # Replace with function body.
