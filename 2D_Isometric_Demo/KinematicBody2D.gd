extends KinematicBody2D

const MOVE_SPEED = 50

onready var raycast = $RayCast2D

onready var player = get_node("../../../../troll")
onready var Animal = get_node("../../../../Animal")
#onready var Path = get_node("../Sprite")

#vou meio q dar merge nos nossos dois codigos pq acho q a sprite bugou tudo
var Player_Hide :bool
var Animal_Hide :bool
var tipo :int #vou ter q fazer um switch case na mão pois não tem
#e tbm pq preciso mudar o estado do inimigo de patrulha pra perseguissão e voltar pra base
# patrulha = 0 perseguir = 1 voltar = 2 moita = 3
#assim eu vou usar teu codigo de base se der ruim fudeo sasgashau

func _ready():
	Player_Hide = false
	Animal_Hide = false
	set_physics_process(true)
	
func _physics_process(delta):
	
	#aqui começa o switch
	if tipo == 0: #andando de boas
		get_parent().set_offset(get_parent().get_offset() +(50*delta)) #seguindo path
		if player == null: #testando se tem o troll
			return
		
		var casto = player.global_position - global_position #não sei oq tu faz aqui
		casto = casto.normalized()
		
		#assim não sei direito oq tu tá fazendo mas vou copiar :v
		var Animal_casto = Animal.global_position - global_position
		Animal_casto = Animal_casto.normalized()
		
		if raycast.is_colliding():  #se tá pegando alguem
			var coll = raycast.get_collider()
			if !Player_Hide:
				if coll.name == "troll": #se esse alguem é o troll
					tipo = 1 #vai pro modo de seguir
			if !Animal_Hide:
				if coll.name == "Animal":
					tipo = 3
	
	if tipo == 1: #seguindo
		var vec_to_player = player.global_position - global_position
		vec_to_player = vec_to_player.normalized()
		global_rotation = atan2(vec_to_player.y, vec_to_player.x)
		move_and_collide(vec_to_player * MOVE_SPEED * delta)
		if !raycast.is_colliding():
			tipo = 0 #era pra ir pro 2 mas não to conseguindo fazer funcionar por agora
		if Player_Hide:
			tipo = 0
	
	if tipo == 2: #voltando pra base
		move_and_slide(Vector2(10,10), Vector2(0,0))
		if raycast.is_colliding():  #se tá pegando alguem
			var coll = raycast.get_collider()
			if coll.name == "troll": #se esse alguem é o troll
				tipo = 1 #vai pro modo de seguir
		if position.x == 0 && position.y == 0:
			tipo = 0
	if tipo == 3: #seguindo animal
		var vec_to_animal = Animal.global_position - global_position
		vec_to_animal = vec_to_animal.normalized()
		global_rotation = atan2(vec_to_animal.y, vec_to_animal.x)
		move_and_collide(vec_to_animal * MOVE_SPEED * delta)
		if !raycast.is_colliding():
			tipo = 0 #era pra ir pro 2 mas não to conseguindo fazer funcionar por agora
		if Animal_Hide:
			tipo = 0
	#aqui termina
	

func _on_Area_Moita_body_entered(body):
	if body.name == "troll":
		print("hue")
		#tipo = 3
		Player_Hide = true
	if body.name == "Animal":
		print("corre")
		Animal_Hide = true

func _on_Area_Moita_body_exited(body):
	if body.name == "troll":
		print("br")
		#tipo = 0
		Player_Hide = false
	if body.name == "Animal":
		print("q o otacu tá puto")
		Animal_Hide= false
