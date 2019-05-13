extends Node2D

onready var imp = preload("res://imp.tscn")
onready var troll = preload("res://troll.tscn")
onready var wild_shape = 0 #0 = troll, 1 = imp, 2 = corno
onready var max_shapes = 2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	remove_child(get_child(0))
	var actual_shape
	
	if wild_shape == 0:
		actual_shape = troll.instance()
	else:
		actual_shape = imp.instance()
	add_child(actual_shape)
	
	#print(get_node("").get_child(1).name)
	#max_shapes = 2
	print(max_shapes)
	#get_node("").get_child(1).hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("polymorph"):
		turn_into_a_monster()
		
#	pass
func turn_into_a_monster():
	var actual_shape
	var pos_x = get_child(0).position.x
	var pos_y = get_child(0).position.y
	remove_child(get_child(0))
	print("previous_shapes: ", wild_shape)
	print("Max_shapes: ", max_shapes)
	if (max_shapes-1 == wild_shape):
		
		wild_shape = 0
	else :
		wild_shape +=  1
	
	
	if wild_shape == 0:
		actual_shape = troll.instance()
	else:
		actual_shape = imp.instance()
	
	
	add_child(actual_shape)
	get_child(0).position.x = pos_x
	get_child(0).position.y = pos_y
	
	print("actual_shape: ",0)