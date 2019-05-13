extends RigidBody2D

onready var player = get_node("../Player")

func _physics_process(delta):
	if $CollisionShape2D.get_colider == player:
		

func _ready():
	pass # Replace with function body.
