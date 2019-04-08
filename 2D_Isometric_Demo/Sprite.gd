
extends Sprite

var top :bool


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

func _physics_process(delta):
	$Ray.set_cast_to(player.global_position)
		
	if $Ray.get_collider() == player:
		#self.rotation = (player.position - self.position).angle()
		if self.position.x < player.position.x:
			self.position.x +=velocity
		if self.position.y < player.position.y:
			self.position.y +=velocity
		if self.position.x > player.position.x:
			self.position.x -=velocity
		if self.position.y > player.position.y:
			self.position.y -=velocity
					#shoot(pos)

