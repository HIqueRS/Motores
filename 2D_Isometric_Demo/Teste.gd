extends KinematicBody2D

const MOVE_SPEED = 50

onready var player = get_node("../Player").get_child(0)
#onready var Path = get_node("../Sprite")

#vou meio q dar merge nos nossos dois codigos pq acho q a sprite bugou tudo
var top :bool
var tipo :int
var free :bool #eu devia limpar os codigos
#vou ter q fazer um switch case na mão pois não tem
#e tbm pq preciso mudar o estado do inimigo de patrulha pra perseguissão e voltar pra base
# patrulha = 0 perseguir = 1 voltar = 2 moita = 3
#assim eu vou usar teu codigo de base se der ruim fudeo sasgashau

func _ready():
	top = true
	free = false
	set_physics_process(true)
	
func _physics_process(delta):
	player = get_node("../Player").get_child(0)
	if player == null: #testando se tem o troll
		return
	
	var casto = player.global_position - global_position #não sei oq tu faz aqui
	casto = casto.normalized()
	
	if free:
		var vec_to_player = player.global_position - global_position
		vec_to_player = vec_to_player.normalized()
		global_rotation = atan2(vec_to_player.y, vec_to_player.x)
		move_and_collide(vec_to_player * MOVE_SPEED * delta)
	

func _on_Animal_Area_body_entered(body):
	if body.name == get_node("../Player").get_child(0).name:
		print("booora")
		free = true
	
