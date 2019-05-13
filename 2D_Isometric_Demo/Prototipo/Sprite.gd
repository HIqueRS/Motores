extends Sprite

var top :bool


# Called when the node enters the scene tree for the first time.
func _ready():
	top = true
	set_physics_process(true)

func _physics_process(delta):
	
	if top :
		get_parent().set_offset(get_parent().get_offset() +(50*delta))
