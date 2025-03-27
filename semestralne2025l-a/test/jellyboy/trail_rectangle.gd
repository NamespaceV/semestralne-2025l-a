# TrailRect.gd
extends Node2D

@export var lifetime := 0.5

func _ready():
	# Animate fade-out
	var tween := create_tween()
	tween.tween_property($MeshInstance2D, "modulate:a", 0.0, lifetime)
	tween.tween_callback(Callable(self, "queue_free"))
