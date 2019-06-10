extends KinematicBody2D
export (int) var detect_radius
export (int) var mov_speed = 250
var vis_color = Color(1.0, 1.0, 1.0, 0.1)
var laser_color = Color(1.0, .329, .298)

onready var player = get_node("../../Player")
onready var animal = get_node("../../Animal")

onready var Pos1 = get_node("../Pos1")
onready var Pos2 = get_node("../Pos2")
var aux

var target
var hit_pos
var is_chasing = false

var animal_is_on_sight = false
var player_is_on_sight = false

var state =0 #-1 - parado 0 - patrulhando  1 - animal 2 - player 3 - coco


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
	
	#padrão
	if state == -1:
		
		if !animal.moita and animal_is_on_sight and aim(animal):
			state = 1
		elif !player.moita and player_is_on_sight and aim(player):
			state = 2
		else:
			state = 0
		pass
	#seguindo path
	elif state == 0:
		path(delta)
		if animal_is_on_sight:
			state = -1
		if player_is_on_sight:
			state = -1
		
		pass
	#seguindo animal
	elif state == 1:
		if !animal.moita and animal_is_on_sight and aim(animal):
			chasing(animal,delta)
		else:
			state = -1
		pass
	#seguindo player
	elif state == 2:
		if !player.moita and player_is_on_sight and aim(player):
			chasing(player,delta)
		else:
			state = -1
		pass
	#seguindo pos
	elif state == 3:
		pass
	
	

func path(delta):
	rotation = (aux.global_position - global_position).angle()
	var vec_to_pos2 = aux.global_position- global_position
	vec_to_pos2 = vec_to_pos2.normalized()
	move_and_collide(vec_to_pos2 * delta *100)
	pass

func aim(var aux_target):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, aux_target.global_position, [self], collision_mask) #posicao inicial do raio #até o position global do alvo #ignorando ele mesmo #colidindo com a mask dele
	if result:
		hit_pos = result.position
		if result.collider.name == aux_target.name:
				$Sprite.self_modulate.r = 1.0
				if !animal.moita:
					return true
	return false



func chasing(var aux_target,delta):
	
	rotation = (aux_target.global_position - global_position).angle()
	var vec_to_payer = aux_target.global_position- global_position
	vec_to_payer = vec_to_payer.normalized()
	move_and_collide(vec_to_payer * delta *100)
	pass


func _on_Visibility_body_entered(body):
	print_debug("ENTROOO", body.name)
	if body.name=="Player":
		player_is_on_sight = true
	if body.name=="Animal":
		animal_is_on_sight = true


func _on_Visibility_body_exited(body):
	if body.name=="Player":
		player_is_on_sight = false
	if body.name=="Animal":
		animal_is_on_sight = false
	

func _on_Area2D_body_entered(body):
	if body.name=="Player" or body.name == "Animal":
		print_debug("RESETOOOOOOUUU")
		#get_tree().reload_current_scene()
		
		Fase.get_script().restart()
		


func _on_Pos1_body_entered(body):
	aux = Pos2
	pass # Replace with function body.


func _on_Pos2_body_entered(body):
	aux = Pos1
	pass # Replace with function body.
