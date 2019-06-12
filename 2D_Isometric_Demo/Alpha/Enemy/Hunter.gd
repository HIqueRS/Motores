extends KinematicBody2D
export (int) var detect_radius
export (int) var mov_speed = 250
var vis_color = Color(1.0, 1.0, 1.0, 0.1)
var laser_color = Color(1.0, .329, .298)

onready var player = get_node("../../Player")
onready var animal = get_node("../../Animal")

onready var Pos1 = get_node("../Pos1")
onready var Pos2 = get_node("../Pos2")
onready var Pos3 = get_node("../Pos3")
var aux

var target
var hit_pos
var is_chasing = false
var is_chasing_animal = false
var is_chasing_player = false

var animal_is_on_sight = false
var player_is_on_sight = false

var aux_target = null
var state =0 #-1 - parado 0 - patrulhando  1 - animal 2 - player 3 - coco
var distraction = false


onready var Fase = get_node("../../../Fase")
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
	
	print(state)
	
	#padrão
	if state == -1:
		
		if !animal.moita and animal_is_on_sight and aim(animal) and !is_chasing_player:
			state = 1
			distraction = false
			is_chasing_animal = true
			
		elif !player.moita and player_is_on_sight and aim(player) and !is_chasing_animal:
			state = 2
			distraction = false
			is_chasing_player = true
			
		elif distraction:
			state = 3
		elif !is_chasing_animal and !is_chasing_player:
			state = 0
			distraction = false
		
			
		
		pass
	#seguindo path
	elif state == 0:
		
		
		if !animal.moita and animal_is_on_sight and aim(animal):
			state = -1
			
		elif !player.moita and player_is_on_sight and aim(player):
			state = -1
		else:
			path(delta,70)
		
		
		pass
	#seguindo animal
	elif state == 1:
		if !animal.moita and animal_is_on_sight and aim(animal):
			chasing(animal,delta,100)
			distraction = false
		else:
			is_chasing_animal = false
			#print_debug("moita? ", !animal.moita, " animal_is_on_sight: ", animal_is_on_sight, " aim(animal) ", aim(animal) )
			state = -1
			
			
		pass
	#seguindo player
	elif state == 2:
		if !player.moita and player_is_on_sight and aim(player):
			chasing(player,delta,100)
			distraction = false
		else:
			is_chasing_player = false
			state = -1
			
		pass
	#seguindo pos
	elif state == 3:
		chasing(Pos3,delta,160) # pra ver ele bugado descomente aqui
		state = -1
		#distraction = false #e comente aqui
		if !animal.moita and animal_is_on_sight:
			state = 1
		elif !player.moita and player_is_on_sight:
			state = 2
		elif !distraction:
			state = -1
		pass
	
	

func path(delta,vel):
	rotation = (aux.global_position - global_position).angle()
	var vec_to_pos2 = aux.global_position- global_position
	vec_to_pos2 = vec_to_pos2.normalized()
	move_and_collide(vec_to_pos2 * delta *vel)
	pass

func aim(var aux_tar):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, aux_tar.global_position, [self], collision_mask) #posicao inicial do raio #até o position global do alvo #ignorando ele mesmo #colidindo com a mask dele
	if result:
		
		if result.collider.name == aux_tar.name:
				$Sprite.self_modulate.r = 1.0
				
				return true
	return false



func chasing(var aux_target,delta,vel):
	
	rotation = (aux_target.global_position - global_position).angle()
	
	var vec_to_payer = aux_target.global_position- global_position
	vec_to_payer = vec_to_payer.normalized()
	move_and_collide(vec_to_payer * delta *vel)
	pass


func _on_Visibility_body_entered(body):
	print_debug("ENTROOO", body.name)
	if body.name=="Player":
		player_is_on_sight = true
		Pos3.global_position = Pos1.global_position
		distraction = false
	if body.name=="Animal":
		animal_is_on_sight = true
		Pos3.global_position = Pos1.global_position
		distraction = false


func _on_Visibility_body_exited(body):
	print_debug("Saiu", body.name)
	if body.name=="Player":
		player_is_on_sight = false
		if !animal_is_on_sight:
			Pos3.global_position = body.global_position
			distraction = true
			
			
	if body.name=="Animal":
		animal_is_on_sight = false
		if !player_is_on_sight:
			Pos3.global_position = body.global_position
			distraction = true
	

func _on_Area2D_body_entered(body):
	if body.name=="Player" or body.name == "Animal":
		print_debug("RESETOOOOOOUUU")
		#get_tree().reload_current_scene()
		
		#Fase.get_script().restart()
		


func _on_Pos1_body_entered(body):
	if body.name == "Hunter":
		aux = Pos2
	pass # Replace with function body.


func _on_Pos2_body_entered(body):
	if body.name == "Hunter":
		aux = Pos1
	pass # Replace with function body.


func _on_Pos3_body_entered(body):
	if body.name == "Hunter":
		aux = Pos2
		Pos3.global_position = Pos1.global_position
		distraction = false
	pass # Replace with function body.
