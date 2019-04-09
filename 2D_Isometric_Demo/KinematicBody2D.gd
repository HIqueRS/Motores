extends KinematicBody2D

const MOVE_SPEED = 50

onready var raycast = $RayCast2D

onready var player = get_node("../../../../troll")
#onready var Path = get_node("../Sprite")

#vou meio q dar merge nos nossos dois codigos pq acho q a sprite bugou tudo
var top :bool
var tipo :int #vou ter q fazer um switch case na mão pois não tem
#e tbm pq preciso mudar o estado do inimigo de patrulha pra perseguissão e voltar pra base
# patrulha = 0 perseguir = 1 voltar = 2 
#assim eu vou usar teu codigo de base se der ruim fudeo sasgashau

func _ready():
	top = true
	set_physics_process(true)
	
func _physics_process(delta):
	
	#aqui começa o switch
	if tipo == 0: #andando de boas
		get_parent().set_offset(get_parent().get_offset() +(50*delta)) #seguindo
		if player == null: #testando se tem o troll
			return
		
		var casto = player.global_position - global_position #não sei oq tu faz aqui
		casto = casto.normalized()
		
		if raycast.is_colliding():  #se tá pegando alguem
			var coll = raycast.get_collider()
			if coll.name == "troll": #se esse alguem é o troll
				tipo = 1 #vai pro modo de seguir
	
	if tipo == 1: #seguindo
		var vec_to_player = player.global_position - global_position
		vec_to_player = vec_to_player.normalized()
		global_rotation = atan2(vec_to_player.y, vec_to_player.x)
		move_and_collide(vec_to_player * MOVE_SPEED * delta)
		if !raycast.is_colliding():
			tipo = 0 #era pra ir pro 2 mas não to conseguindo fazer funcionar por agora
	
	if tipo == 2: #voltando pra base
		move_and_slide(Vector2(10,10), Vector2(0,0))
		if raycast.is_colliding():  #se tá pegando alguem
			var coll = raycast.get_collider()
			if coll.name == "troll": #se esse alguem é o troll
				tipo = 1 #vai pro modo de seguir
		if position.x == 0 && position.y == 0:
			tipo = 0
	
	#aqui termina
	