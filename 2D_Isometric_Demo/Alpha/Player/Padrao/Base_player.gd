extends KinematicBody2D

#onready var MOTION_SPEED = 160 # Pixels/second
var MOTION_SPEED
var MOTION_SPEED_ON_MOITA
var MOTION_SPEED_OFF_MOITA
onready var anhanga = preload("res://Alpha/Player/Padrao/Anhanga.tscn")
onready var onca = preload("res://Alpha/Player/Transf - Onça/TransfOnca.tscn")
onready var tatu = preload("res://Alpha/Player/Transf - Tatu/TransfTatu.tscn")

var OncaT = true #se pode transformar
var TatuT = true
var AnhangaT = true #se tá na forma humanoide

var WildShapeOnca = true
var WildShapeTatu = true


var moita = false

onready var animal = get_node("../Animal")#acho que ele tem q se chamar animal

func _ready():

	var actual_shape
	actual_shape = anhanga.instance()
	add_child(actual_shape)
	
	MOTION_SPEED = get_child(1).MOTION_SPEED
	MOTION_SPEED_OFF_MOITA = MOTION_SPEED
	MOTION_SPEED_ON_MOITA = MOTION_SPEED/2
	
	
	pass

func _physics_process(delta):
	
	if moita:
		get_child(1).get_child(1).get_child(0).visible = true
		MOTION_SPEED = MOTION_SPEED_ON_MOITA
	else:
		get_child(1).get_child(1).get_child(0).visible = false
		MOTION_SPEED = get_child(1).MOTION_SPEED
		#pass
	if Input.is_action_just_pressed("action"): #so teset 
		animal.stop()
		pass
	Movement()
	Transformations()

func Movement():
	#if Input.is_action_just_pressed("R"):
	#	get_tree().reload_current_scene()
	var motion = Vector2()
	
	if Input.is_action_pressed("move_up"):
		motion += Vector2(0, -1)
	if Input.is_action_pressed("move_bottom"):
		motion += Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		motion += Vector2(1, 0)
	motion = motion.normalized() * MOTION_SPEED

	move_and_slide(motion)
	pass

func Transformations():
	if get_child(1).name == "Onca":
		if get_child(1).go_back:
			Back_to_normal()
		
	if Input.is_action_just_pressed("oncaT"): #aperta pra transformar
		if (OncaT and WildShapeOnca): #se pode virar ele vira
			Polymorph_onca()
			WildShapeOnca = false
			pass
		elif (!AnhangaT): #se não pode e ele não é humano ele vai virar humano
			Back_to_normal()
			pass
		pass
	
	if Input.is_action_just_pressed("tatuT"): #aperta pra transformar
		if (TatuT  and WildShapeTatu): #se pode virar ele vira
			Polymorph_tatu()
			WildShapeTatu = false
			pass
		elif (!AnhangaT): #se não pode e ele não é humano ele vai virar humano
			Back_to_normal()
			pass
		pass
	
	pass

func Polymorph_onca():
	var actual_shape = onca.instance()
	
	var pos_x = get_child(1).position.x
	var pos_y = get_child(1).position.y
	
	remove_child(get_child(1))
	
	add_child(actual_shape)
	get_child(1).position.x = pos_x
	get_child(1).position.y = pos_y
	
	MOTION_SPEED = get_child(1).MOTION_SPEED
	
	AnhangaT = false #não é humanoide
	OncaT = false #não pode mais virar onca
	
	pass

func Polymorph_tatu():
	var actual_shape = tatu.instance()
	
	var pos_x = get_child(1).position.x
	var pos_y = get_child(1).position.y
	
	remove_child(get_child(1))
	
	add_child(actual_shape)
	get_child(1).position.x = pos_x
	get_child(1).position.y = pos_y
	
	MOTION_SPEED = get_child(1).MOTION_SPEED
	
	AnhangaT = false #não é humanoide
	TatuT = false #não pode mais virar onca
	
	pass

func Back_to_normal():
	var actual_shape = anhanga.instance()
	
	var pos_x = get_child(1).position.x
	var pos_y = get_child(1).position.y
	
	remove_child(get_child(1))
	
	add_child(actual_shape)
	get_child(1).position.x = pos_x
	get_child(1).position.y = pos_y
	
	MOTION_SPEED = get_child(1).MOTION_SPEED
	
	AnhangaT = true #é humanoide
	TatuT = true
	OncaT = true
	
	pass
