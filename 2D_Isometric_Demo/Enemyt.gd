extends KinematicBody2D


onready var visao = get_node("visao")
onready var circulo = get_node("circulo")
var pega_ele = false
var distancia_minima = 60
var move_speed = 30
onready var pf = get_node("../Playert")
onready var ray = get_node("RayCast2D")

func _physics_process(delta):
	ray.cast_to = pf.global_position - global_position
	if ray.get_collider() == pf :
		move_and_slide(pf.global_position - global_position)
#	var goto = (pf.global_position - global_position).normalized()
#	var distance = global_position.distance_to(pf.global_position)
#	if pega_ele:
#		var vec_to_player = pf.global_position - global_position
#		vec_to_player = vec_to_player.normalized()
#		global_rotation = atan2(vec_to_player.y, vec_to_player.x)
#		move_and_slide(goto * move_speed )
#	pass
## Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta):
##	pass
#
#
#func _on_Area2D_body_entered(body):
#	if body != pf:
#		return
#	print("achei")
#	pega_ele = true
#
#	pass # Replace with function body.
#
#
#func _on_Area2D_body_exited(body):
#		if body == pf:
#			pega_ele = false
#		return
#		pass # Replace with function body.
