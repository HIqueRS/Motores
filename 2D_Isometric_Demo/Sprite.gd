extends Sprite

var top :bool


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if Input.is_action_pressed("move_up"):
		top = false
	if Input.is_action_pressed("move_bottom"):
		top = true
	if top :
		get_parent().set_offset(get_parent().get_offset() +(50*delta))
