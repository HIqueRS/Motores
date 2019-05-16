extends Node2D

var NFase = 0

onready var Fase1 = preload("res://Alpha/Fases/FaseTeste.tscn")
var FaseAtual

var Fases = [preload("res://Alpha/Fases/FaseTeste.tscn"),preload("res://Alpha/Fases/teste2.tscn")]
var meio = preload("res://Alpha/Telas/Meio.tscn")

var intervalo = false

var next = false
var goto = false

func _ready():
	
	if NFase == 0:
		FaseAtual = Fases[NFase].instance()
	
	add_child(FaseAtual)
	
	pass

func _process(delta):
	
	next = get_child(0).next
	if next:
		next = false
		#midle_stage()
		pass_stage()
	
	if intervalo:
		goto = get_child(0).get_next()
		#print_debug(goto)
		if goto:
			print_debug("ue")
			intervalo = false
			pass_stage()
			
		

func midle_stage():
	FaseAtual = meio.instance()
	remove_child(get_child(0))
	add_child(FaseAtual)
	intervalo = true
	pass

func pass_stage():
	
	NFase += 1
	FaseAtual = Fases[NFase].instance()
	remove_child(get_child(0))
	add_child(FaseAtual)
	
	pass
