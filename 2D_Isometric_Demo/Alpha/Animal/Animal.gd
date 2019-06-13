extends KinematicBody2D

var moita = false

onready var MOVE_SPEED 

onready var player = get_node("../Player")
var free = false
var parado = false

var play_sound = false

var ok = true
var dist


func _ready():
	MOVE_SPEED = get_child(0).MOTION_SPEED
	set_physics_process(true)
	pass  

func _physics_process(delta):
	
	if !parado && free:
		follow(delta)
	
	pass

func follow(delt):
	
	if player == null:
		return
	
	if play_sound:
		play_sound = false
		$"AudioStreamPlayer".play()
		pass
	
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	
	if distance():
		global_rotation = atan2(vec_to_player.y, vec_to_player.x)
		move_and_collide(vec_to_player * MOVE_SPEED * delt)
	
	pass

func distance():	
	
	dist = global_position - player.global_position
	
	if dist.x < 0:
		dist.x = dist.x * -1
	if dist.y < 0:
		dist.y = dist.y * -1
	
	if dist.x <10 && dist.y <10:
		ok = false
	else:
		ok = true
	
	return ok
	pass


func stop():
	if !get_child(0).agressive:
		parado = !parado
	pass

func _on_Animal_Area_entered(body):
	if body.name == "Player":
		if !free:
			body.WildShapeOnca = true
			body.WildShapeTatu = true
			free = true
			play_sound = true
		
	pass # Replace with function body.
