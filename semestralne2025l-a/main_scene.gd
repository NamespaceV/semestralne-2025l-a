extends Node2D

@export var button_teleport_area : Rect2

@onready var score_label: Label = $Test/ColorRect/Score
@onready var click_me_button = $Test/ClickMeButton

@onready var test_layer = $Test
@onready var main_layer = $Main

var counter = 0

func _ready() -> void:
	click_me_button.pressed.connect(on_button_clicked)
	score_label.text = ""

func on_button_clicked() -> void:
	var x = button_teleport_area.position.x + randf() * button_teleport_area.size.x
	var y = button_teleport_area.position.y + randf() * button_teleport_area.size.y
	click_me_button.position = Vector2(x, y)
	counter += 1
	score_label.text = "Score: %d" % [counter]


func _on_start_jelly_pressed() -> void:
	get_tree().change_scene_to_file("res://test/jellyboy/test_scene.tscn")


func _on_start_zephyr_pressed() -> void:
	get_tree().change_scene_to_file("res://test/zephyr/movement.tscn")


func _on_start_noome_pressed() -> void:
	get_tree().change_scene_to_file("res://test/noome/game.tscn")


func _on_start_pixelnoob_pressed() -> void:
	get_tree().change_scene_to_file("res://test/pixelnoob/scenes/pixelnoob_movement.tscn")


func _on_start_szejtan_pressed() -> void:
	get_tree().change_scene_to_file("res://test/szejtan/movement-szejtan.tscn")


func _on_test_pressed() -> void:
	main_layer.hide()
	test_layer.show()


func _on_test_exit_pressed() -> void:
	main_layer.show()
	test_layer.hide()


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level1.tscn")
