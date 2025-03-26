extends Node2D

func _ready():
	add_child(Global.current_level.instantiate())
