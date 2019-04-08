extends KinematicBody2D

const MOVE_SPEED = 10

onready var raycast = $RayCast2D

onready var player = get_node("../../../../troll")
onready var Path = get_node("../Sprite")

func _physics_process(delta):
	if player == null:
		return
		
	var casto = player.global_position - global_position
	casto = casto.normalized()
	
	#persegue o player
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "troll":
			#seta andar no path false
			Path.top = false
			var vec_to_player = player.global_position - global_position
			vec_to_player = vec_to_player.normalized()
			global_rotation = atan2(vec_to_player.y, vec_to_player.x)
			move_and_collide(vec_to_player * MOVE_SPEED * delta)
			#else seta andar no path true
		else:
			Path.top = true
	else:
		Path.top = true