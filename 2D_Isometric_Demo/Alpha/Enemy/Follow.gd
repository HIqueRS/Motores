extends KinematicBody2D

onready var Pos = get_node("../Positions")

var NumPos

var aux

export (int) var velocity

func _ready():
	
	NumPos = Pos.get_child_count() -1
	aux =0
	
	for x in NumPos:
		Pos.get_child(x).get_child(0).get_child(0).disabled = true
		pass
	pass

func _physics_process(delta):
	path(delta,velocity)
	pass

func path(delta,vel):
	disable_pos()
	Pos.get_child(aux).get_child(0).get_child(0).disabled = false
	rotation = (Pos.get_child(aux).global_position - global_position).angle()
	var vec_to_pos = Pos.get_child(aux).global_position- global_position
	vec_to_pos = vec_to_pos.normalized()
	move_and_collide(vec_to_pos * delta *vel)
	pass

func _on_Pos_body_entered(body):
	if body.name == "Follow":
		#Pos.get_child(aux).get_child(0).get_child(0).disabled = true
		aux += 1
		if aux > NumPos:
			aux = 0
	pass # Replace with function body.

func disable_pos():
	for x in NumPos:
		Pos.get_child(x).get_child(0).get_child(0).disabled = true
		pass
	pass