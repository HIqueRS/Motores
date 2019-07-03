tool
extends EditorPlugin

var dock

func _enter_tree():
	#add_custom_type( "Simple path", "KinematicBody2D", preload("res://addons/SimplePath/Follow.gd"), preload("res://Alpha/Enemy/inimigo.png"))
	#add_child("res://addons/SimplePath/Path.tscn", true)
	dock = preload("res://addons/SimplePath/Path.tscn").instance()
#	add_control_to_dock( EditorPlugin.DOCK_SLOT_LEFT_BR, dock)
	pass

func _exit_tree():
	remove_custom_type("Simple path")
	pass

#func _enter_tree(): 
#    # First load the dock scene and instance it:
#    dock = preload("res://addons/snippets_plugin/snippets_dock.tscn").instance()
#    # Add the loaded scene to the docks:
#    add_control_to_dock( EditorPlugin.DOCK_SLOT_LEFT_BR, dock)
#
#func get_ext_editor():
#    # Check for external editor in Editor Settings
#    var ext_editor = ed.get_setting("text_editor/external/exec_path")
#    if not ext_editor == "":
#        dock.ext_editor_path = ext_editor
#    else:
#        dock.ext_editor_path = ""