extends Node2D
var ms    =0
var u_sec =0
var d_sec =0
var u_min =0
var d_min =0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ms > 9:
		ms = 0
		u_sec +=1
	if u_sec > 9:
		u_sec = 0
		d_sec +=1
	if d_sec > 5:
		d_sec = 0
		u_min +=1
	if u_min > 9:
		u_min = 0
		d_min +=1
	#$Time.set_text(str(d_min)+str(u_min)+":"+str(d_sec)+str(u_sec)+":"+str(ms))
	Global.timestring = str(d_min)+str(u_min)+":"+str(d_sec)+str(u_sec)+":"+str(ms)

func _on_Timer_timeout():
	ms+=1;
	pass # Replace with function body.
