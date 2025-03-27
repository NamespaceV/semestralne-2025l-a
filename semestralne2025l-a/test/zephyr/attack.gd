extends Node2D

@onready var anim = $AnimationPlayer

func _ready() -> void:
	anim.animation_finished.connect(on_animation_finished)

func on_animation_finished(name:String) -> void:
	queue_free()
