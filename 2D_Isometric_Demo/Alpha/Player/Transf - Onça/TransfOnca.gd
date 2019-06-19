extends CollisionShape2D

var MOTION_SPEED = 320
var go_back = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D2/TextureProgress.visible = true;
	$Camera2D2/TextureProgress.value = $Timer.get_time_left() 
	if $Timer.get_time_left() <= 0:
		$Camera2D2/TextureProgress.visible = false;
	#$timebar.ADD_PROPERTYNZ(PropertyInfo(Variant::BOOL, "is_toplevel", PROPERTY_HINT_NONE, "", PROPERTY_USAGE_EDITOR), "set_as_toplevel", "is_set_as_toplevel")

	pass


func _on_Timer_timeout():
	go_back = true;
	$Camera2D2/TextureProgress.visible = false;
	pass # Replace with function body.
