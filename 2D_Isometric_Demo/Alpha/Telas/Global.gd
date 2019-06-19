extends Node

var score

var savegame = File.new()
var save_path = "user://savegame.save"
var save_data = 0

var Cont = false


var reset = false

var state = 0

var timestring

func _ready():
	#savegame.file_delete()
	if not savegame.file_exists(save_path):
    	create_save()
	
	pass

func create_save():
	savegame.open(save_path,File.WRITE)
	savegame.store_var(save_data)
	savegame.close()
	pass

func save(stage):
	
	
	
	save_data = stage
	
	
	
	savegame.open(save_path, File.WRITE) #open file to write
	savegame.store_var(save_data)
	 #store the data
	savegame.close() # close the file
	
func read_savegame():
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	
	savegame.close() #close the file
	return save_data #return the value