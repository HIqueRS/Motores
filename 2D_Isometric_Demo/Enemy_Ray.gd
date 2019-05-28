extends KinematicBody2D

var laser_color = Color(1.0, .329, .298)
var target
var hit_pos
var Motion_speed = 100

onready var player = get_node("../Player")

func _ready():
	pass

func _physics_process(delta):
	update()
	if target:
		mirar(delta)

func mirar(Delt):
	
	if player == null:
		return
	
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position,target.position,[self],collision_mask)
	
#	hit_pos = []
#	hit_pos.append(result.position)

	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	
	if result:
		if result.collider.name == "Player":
			#print_debug("ray bateu no player")
			global_rotation = atan2(vec_to_player.y, vec_to_player.x)
			move_and_collide(vec_to_player * Motion_speed * Delt)
			
			$Sprite.self_modulate.r = 1.0
#				



#func _draw():
#
#	if target:
#		for hit in hit_pos:
#
#			draw_line(Vector2(), (hit - position).rotated(-rotation), laser_color)

func _on_Visao_entered(body):
	if target:
		return
	target = body
	print_debug( body.name , " entrou na visao")
	
	pass # Replace with function body.


func _on_Visao_exited(body):
	if body == target:
		target = null
		$Sprite.self_modulate.r = 0.2
		
		print_debug( body.name , " saiu da visao")
		
	pass # Replace with function body.
