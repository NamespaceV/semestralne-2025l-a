extends Control

func _on_level_1_pressed() -> void:
	Global.current_level = load("res://test/noome/levels/level1/level1.tscn")
	get_tree().change_scene_to_file("res://test/noome/game.tscn")
	
