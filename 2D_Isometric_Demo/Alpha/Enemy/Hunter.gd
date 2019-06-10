extends KinematicBody2D
export (int) var detect_radius
export (int) var mov_speed = 250
var vis_color = Color(1.0, 1.0, 1.0, 0.1)
var laser_color = Color(1.0, .329, .298)

onready var player = get_node("../Player")
onready var animal = get_node("../Animal")

onready var Pos1 = get_node("../Pos1")
onready var Pos2 = get_node("../Pos2")
onready var Pos3 = get_node("../Pos3")
var aux

var target
var hit_pos
var is_chasing = false

var animal_is_on_sight = false
var player_is_on_sight = false

<<<<<<< Updated upstream
var aux_target = null
=======
var state =0 #-1 - parado 0 - patrulhando  1 - animal 2 - player 3 - coco
var distraction= false


onready var Fase = get_node("../../../Fase")
>>>>>>> Stashed changes
# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
#	$Sprite.self_modulate = Color(0.2, 0, 0)
#	var shape = CircleShape2D.new()
#	shape.radius = detect_radius
#	$Visibility/CollisionShape2D.shape = shape
	aux = Pos2
	pass


func _physics_process(delta):
	update()
	
	if target:
		aim()
	if is_chasing and target:
		if true: #not target.get("moita") == null: #Se o alvo tem uma variavel moita
			if !target.moita:
				var vec_to_payer = target.position- global_position
				vec_to_payer = vec_to_payer.normalized()
				move_and_collide(vec_to_payer * delta *100)
			else: #Se o alvo entrou na moita
				print_debug("Entrou Na Moita?")
				if !animal_is_on_sight:
					print_debug(animal_is_on_sight)
					target.transform 
					aux_target = target
					target = null
					is_chasing = false
				else:
					print_debug("ALVO ANIMAL")
					
		
	else:
		#Se o alvo saiu da moita e está no campo de visão do hunter
		if aux_target:
			print_debug("NAO DEVIA ENTRAR AQ COM O ANIMAL")
			if !aux_target.moita:
				target = aux_target
				is_chasing = true
				aux_target = false
				
		#parent.set_offset(parent.get_offset() + mov_speed * delta)
		var vec_to_pos2 = aux.position- global_position
		vec_to_pos2 = vec_to_pos2.normalized()
		move_and_collide(vec_to_pos2 * delta *100)
		
		
<<<<<<< Updated upstream
		
		pass
=======
		if !animal.moita and animal_is_on_sight and aim(animal):
			state = 1
			distraction = false
		elif !player.moita and player_is_on_sight and aim(player):
			state = 2
			distraction = false
		elif distraction:
			state = 3
		else:
			state = 0
		pass
	#seguindo path
	elif state == 0:
		chasing(aux,delta)
		if animal_is_on_sight:
			state = -1
		if player_is_on_sight:
			state = -1
		
		pass
	#seguindo animal
	elif state == 1:
		if !animal.moita and animal_is_on_sight and aim(animal):
			chasing(animal,delta)
			distraction = false
		else:
			state = -1
		pass
	#seguindo player
	elif state == 2:
		if !player.moita and player_is_on_sight and aim(player):
			chasing(player,delta)
			distraction = false
		else:
			state = -1
		pass
	#seguindo pos
	elif state == 3:
		chasing(Pos3,delta)
		
		if !animal.moita and animal_is_on_sight and aim(animal):
			state = 1
		elif !player.moita and player_is_on_sight and aim(player):
			state = 2
		elif !distraction:
			state = 0
		pass
	
	
>>>>>>> Stashed changes

func aim():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, target.position, [self], collision_mask) #posicao inicial do raio #até o position global do alvo #ignorando ele mesmo #colidindo com a mask dele
	if result:
		hit_pos = result.position
		if result.collider.name == "Player" or result.collider.name == "Animal":
			$Sprite.self_modulate.r = 1.0
			rotation = (target.position - position).angle()
			if !is_chasing:
				is_chasing = true
				#move_and_slide(player.position-global_position)


#func _draw():
	#draw_circle(Vector2(), detect_radius, vis_color)
	#if target:
#		draw_circle((hit_pos - position).rotated(-rotation),5, laser_color)
#		draw_line(Vector2(), (hit_pos- position).rotated(-rotation), laser_color)


func _on_Visibility_body_entered(body):
	if body.name=="Player":
		player_is_on_sight = true
		Pos3.global_position = Pos1.global_position
		distraction = false
	if body.name=="Animal":
		animal_is_on_sight = true
<<<<<<< Updated upstream
	if body.name=="Player" or body.name == "Animal":
		print_debug("ENTROOO")
		if target:
			return
		target = body
		$Sprite.self_modulate.r = 1.0
=======
		Pos3.global_position = Pos1.global_position
		distraction = false
		

>>>>>>> Stashed changes

func _on_Visibility_body_exited(body):
	if aux_target:
		if body.name == aux_target.name: #Se o alvo ta escondido na moita e saiu do campo de visão do hunter
			aux_target = null
	if body.name=="Player":
		player_is_on_sight = false
		if !animal_is_on_sight:
			Pos3.global_position = body.global_position
			distraction = true
		
	if body.name=="Animal":
		animal_is_on_sight = false
<<<<<<< Updated upstream
		
	if body == target:
		if body.name == "Player" and animal_is_on_sight:
			print_debug("TROCOU O ALVO")
			target = animal
			is_chasing = true
		elif body.name == "Animal" and player_is_on_sight:
			target = player
		else:
			print_debug("SAIUUUUUU")
			target = null
			is_chasing = false
			#PERDEU O ALVO
			$Sprite.self_modulate.r = 0.2
=======
		if !player_is_on_sight:
			Pos3.global_position = body.global_position
			distraction = true
	
>>>>>>> Stashed changes

func _on_Area2D_body_entered(body):
	if body.name=="Player" or body.name == "Animal":
		print_debug("RESETOOOOOOUUU")
		get_tree().reload_current_scene()


func _on_Pos1_body_entered(body):
	aux = Pos2
	pass # Replace with function body.


func _on_Pos2_body_entered(body):
	aux = Pos1
	pass # Replace with function body.

<<<<<<< Updated upstream
func distracao(posicao):
	var distraction = Position2D.new()
	
=======

func _on_Pos3_body_entered(body):
	if body.name == "Hunter":
		aux = Pos2
		Pos3.global_position = Pos1.global_position
		distraction = false
	pass # Replace with function body.
>>>>>>> Stashed changes
