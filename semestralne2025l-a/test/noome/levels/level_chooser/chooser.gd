extends Node2D

# Dużo tu powtórzeń, pewnie coś da się uprościć jakąś funckją ale na razie 
# działa więc zostawiam. 

var current_levels_id = 0

var levels1_3 = load("res://test/noome/levels/level_chooser/levels_1_3.tscn")
var levels4_6 = load("res://test/noome/levels/level_chooser/levels_4_6.tscn")

var levels_list = [levels1_3, levels4_6]


func _ready():
	current_levels_id = 0
	$ColorRect.add_child(levels_list[current_levels_id].instantiate())


func _on_next_pressed() -> void:
	if current_levels_id < len(levels_list) - 1:
		current_levels_id += 1
		$ColorRect.get_child(-1).queue_free() # questionable ale działa
		$ColorRect.add_child(levels_list[current_levels_id].instantiate())
		
		if current_levels_id == len(levels_list) - 1:
			$ColorRect/Next.visible = false
			$ColorRect/Next.disabled = true
	
	if current_levels_id != 0:
		$ColorRect/Previous.visible = true
		$ColorRect/Previous.disabled = false


func _on_previous_pressed() -> void:
	if current_levels_id != 0:
		current_levels_id -= 1
		$ColorRect.get_child(-1).queue_free() # questionable ale działa
		$ColorRect.add_child(levels_list[current_levels_id].instantiate())
		
		if current_levels_id == 0:
			$ColorRect/Previous.visible = false
			$ColorRect/Previous.disabled = true
	
	if current_levels_id != len(levels_list) - 1:
		$ColorRect/Next.visible = true
		$ColorRect/Next.disabled = false


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://test/noome/ui/menu/main_menu.tscn")
