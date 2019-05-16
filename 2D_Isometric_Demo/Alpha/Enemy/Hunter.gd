extends KinematicBody2D
export (int) var detect_radius
export (int) var mov_speed = 250
var vis_color = Color(1.0, 1.0, 1.0, 0.1)
var laser_color = Color(1.0, .329, .298)

onready var player = get_node("../Player")
onready var animal = get_node("../Animal")

var target
var hit_pos
var is_chasing = false

var animal_is_on_sight = false
var player_is_on_sight = false

# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.self_modulate = Color(0.2, 0, 0)
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	$Visibility/CollisionShape2D.shape = shape


func _physics_process(delta):
	update()
	if target:
		aim()
	if is_chasing and target:
		if !target.moita:
			move_and_slide(target.position-global_position)

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
	if body.name=="Animal":
		animal_is_on_sight = true
	if body.name=="Player" or body.name == "Animal":
		print_debug("ENTROOO")
		if target:
			return
		target = body
		$Sprite.self_modulate.r = 1.0

func _on_Visibility_body_exited(body):
	if body.name=="Player":
		player_is_on_sight = false
	if body.name=="Animal":
		animal_is_on_sight = false
	if body == target:
		if body.name == "Player" and animal_is_on_sight:
			target = animal
		elif body.name == "Animal" and player_is_on_sight:
			target = player
		else:
			print_debug("SAIUUUUUU")
			target = null
			is_chasing = false
			$Sprite.self_modulate.r = 0.2

func _on_Area2D_body_entered(body):
	if body.name=="Player" or body.name == "Animal":
		print_debug("RESETOOOOOOUUU")
		get_tree().reload_current_scene()
