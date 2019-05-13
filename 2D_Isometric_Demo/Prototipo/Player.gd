extends KinematicBody2D

onready var hit = get_node("../Reset")
# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 160 # Pixels/second


func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("move_up"):
		motion += Vector2(0, -1)
	#	$RayCast2D.position.x = -35         
	#	$RayCast2D.position.y = -55 # pra cima
		
	if Input.is_action_pressed("move_bottom"):
		motion += Vector2(0, 1)
	#	$RayCast2D.position.x = -35         
	#	$RayCast2D.position.y = 55 # pra baixo
		
	if Input.is_action_pressed("move_left"):
		motion += Vector2(-1, 0)
	#	$RayCast2D.position.x = -70         
	#	$RayCast2D.position.y = 0 # esquerda

	if Input.is_action_pressed("move_right"):
		motion += Vector2(1, 0)
	#	$RayCast2D.position.x = 0         
	#	$RayCast2D.position.y = 0 #direita
	
		
	motion = motion.normalized() * MOTION_SPEED

	move_and_slide(motion)
	
	if $RayCast2D.get_collider() == hit:
     position.x = 100
     position.y = 100
	if $RayCast2D2.get_collider() == hit:
     position.x = 100
     position.y = 100
	if $RayCast2D3.get_collider() == hit:
     position.x = 100
     position.y = 100
	if $RayCast2D4.get_collider() == hit:
     position.x = 100
     position.y = 100