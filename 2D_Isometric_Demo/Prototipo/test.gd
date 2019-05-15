extends KinematicBody2D

onready var pf = get_node("../Playert")
onready var ray = get_node("RayCast2D")

var pega_ele = false
var move_speed = 30

func _physics_process(delta):
	ray.cast_to = pf.global_position
	
	
	#move_and_slide(pf.global_position - global_position)
	var goto = (pf.global_position).normalized()
	var distance = global_position.distance_to(pf.global_position)
	
	var vec_to_player = pf.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	
	if pega_ele && ray.get_collider() == pf :
		
		#rotation = atan2(vec_to_player.y, vec_to_player.x)
		#ray.rotation += atan2(vec_to_player.y, vec_to_player.x);
		pass

	move_and_slide(goto * move_speed )

	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_body_entered(body):
	if body == pf:
		pega_ele = true
		print("achei")
		return
	
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if body == pf:
		pega_ele = false
	return
	pass # Replace with function body.
