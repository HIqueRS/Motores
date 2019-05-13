extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
onready var MOTION_SPEED = 160 # Pixels/second

onready var actual_shape = 0 #0=goblin 1=imp
const MAX_SHAPES = 1
onready var actual_sprite = get_child(0)
onready var actual_collision = get_child(1)


func _ready():
	get_child(2).hide() #imp sprite
	get_child(3).disabled = true #imp collision
	
	pass


func wild_shape():
	actual_sprite.hide()
	actual_collision.disabled = true
	
	if actual_shape == 1: #se ele for imp:
		#vira goblin
		actual_shape = 0
		actual_sprite = get_child(0)
		actual_collision = get_child(1)
		MOTION_SPEED = 160
		
		
		
	else:
		actual_shape +=1
		actual_sprite = get_child(2)
		actual_collision = get_child(3)
		
		MOTION_SPEED = 300
		
	actual_sprite.show()
	actual_collision.disabled = false
	pass


func _physics_process(delta):
	
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
	
	
	#transformação
	if Input.is_action_just_pressed("polymorph"):
		wild_shape()


func _on_Area2D_body_entered(body):
	if body.name == "troll":
		print ("sla")
		get_tree().reload_current_scene()
	if body.name == "Animal":
		print ("cara isso ae")
		get_tree().reload_current_scene()


func _on_Flag_body_entered(body):
	if body.name == "Animal":
		print ("Parabens voce ganhou")
		get_tree().reload_current_scene()
	pass # Replace with function body.
