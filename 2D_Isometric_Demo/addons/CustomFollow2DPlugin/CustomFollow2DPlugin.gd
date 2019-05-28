tool
extends EditorPlugin
#res://addons/CustomFollow2DPlugin/
#res://addons/CustomFollow2DPlugin/

var import_plugin

func _enter_tree():
	#import_plugin = preload("res://addons/CustomFollow2DPlugin/Follow.gd").new()
	add_custom_type("CustomFollow2D", "PathFollow2D", preload("Follow.gd"), preload("snake.png"))

func _exit_tree():
	remove_custom_type("CustomFollow2D")