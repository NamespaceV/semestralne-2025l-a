extends Node
# singleton Global

var current_level = load("res://test/noome/levels/level1/level1.tscn")


func _enter_tree() -> void:
	Console.add_command("menu", go_to_main_menu)

func go_to_main_menu():
	get_tree().change_scene_to_file("res://main_scene.tscn")
