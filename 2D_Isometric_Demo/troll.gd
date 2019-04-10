extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 160 # Pixels/second


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
