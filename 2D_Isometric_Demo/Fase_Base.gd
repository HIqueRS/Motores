extends Node2D

var NFase = 0

onready var Fase1 = preload("res://Alpha/Fases/FaseTeste.tscn")
var FaseAtual

var Fases = [preload("res://Alpha/Fases new/Fase01.tscn"),
			 preload("res://Alpha/Fases new/Fase02.tscn"),
			 preload("res://Alpha/Fases new/Fase03.tscn"),
			 preload("res://Alpha/Fases new/Fase04.tscn"),
			 preload("res://Alpha/Fases new/Fase05.tscn"),
			 preload("res://Alpha/Fases new/Fase06.tscn"),
			 preload("res://Alpha/Fases new/Fase07.tscn"),
			 preload("res://Alpha/Fases new/Fase08.tscn"),
			 preload("res://Alpha/Fases new/Fase00.tscn")]

var intervalo = false


var next = false
var goto = false
var restart = false

var Cont = false

func _ready():
	
	Cont = Global.Cont
	if Cont:
		NFase = Global.read_savegame()
	else:
		NFase = 0
	
	FaseAtual = Fases[NFase].instance()
	
	add_child(FaseAtual)
	
	pass

func _process(delta):
	if Input.is_action_just_pressed("R"):
		Global.reset=true
		
	if Global.reset:
		Restar_Level()
		Global.reset = false
		
		
		
		
	next = get_child(0).next
	restart = get_child(0).restart
	
	if restart:
		
		pass
	
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
	#FaseAtual = meio.instance()
	remove_child(get_child(0))
	add_child(FaseAtual)
	intervalo = true
	pass

func pass_stage():
	
	NFase += 1
	Global.save(NFase)
	FaseAtual = Fases[NFase].instance()
	remove_child(get_child(0))
	add_child(FaseAtual)
	
	pass
	
	
func Restar_Level():
	FaseAtual = Fases[NFase].instance()
	remove_child(get_child(0))
	add_child(FaseAtual)