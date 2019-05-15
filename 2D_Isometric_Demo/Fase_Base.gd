extends Node2D

var NFase = 0

onready var Fase1 = preload("res://Alpha/Fases/FaseTeste.tscn")
var FaseAtual

var Fases = [preload("res://Alpha/Fases/FaseTeste.tscn"),preload("res://Alpha/Fases/teste2.tscn")]

var next = false

func _ready():
	
	if NFase == 0:
		FaseAtual = Fases[NFase].instance()
	
	add_child(FaseAtual)
	
	pass

func _process(delta):
	
	next = get_child(0).next
	if next:
		next = false
		NFase += 1
		FaseAtual = Fases[NFase].instance()
		remove_child(get_child(0))
		add_child(FaseAtual)
		
		
	
	pass
