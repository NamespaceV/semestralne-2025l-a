extends Node2D

@onready var player = load("res://test/noome/characters/player/player.tscn")

func _ready():
	add_child(Global.current_level.instantiate())
	add_child(player.instantiate())
