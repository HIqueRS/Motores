extends KinematicBody2D



const MOVE_SPEED = 160

onready var player = get_node("../Player")
var free = false
var parado = false

#var teste = true
#var dist
#var sla
#dist = global_position - player.global_position
#	if dist.x < 0:
#		dist.x = dist.x * -1
#	if dist.y < 0:
#		dist.y = dist.y * -1
#	print_debug(dist)
#	if dist.x <2 && dist.y <2:
#		free = false
#		pass

func _ready():
	set_physics_process(true)
	pass  

func _physics_process(delta):
	
	if player == null:
		return
	
	
	
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	
	
	if !parado:
		if free:
			global_rotation = atan2(vec_to_player.y, vec_to_player.x)
			move_and_collide(vec_to_player * MOVE_SPEED * delta)
	pass

func _on_tatu(body):
	
	if body.name == "Player":
		free = true
	pass 

func stop():
	parado = !parado
	pass