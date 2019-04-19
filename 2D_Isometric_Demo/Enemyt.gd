extends KinematicBody2D

onready var visao = get_node("visao")
onready var circulo = get_node("circulo")
onready var player = get_node("../Playert")
var pega_ele = false
var distancia_minima = 60
var move_speed = 30
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var goto = (player.global_position - global_position).normalized()
	var distance = global_position.distance_to(player.global_position)
	if pega_ele:
		var vec_to_player = player.global_position - global_position
		vec_to_player = vec_to_player.normalized()
		global_rotation = atan2(vec_to_player.y, vec_to_player.x)
		move_and_slide(goto * move_speed )
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body != player:
		return
	print("achei")
	pega_ele = true
	
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
		if body == player:
			pega_ele = false
		return
		pass # Replace with function body.
