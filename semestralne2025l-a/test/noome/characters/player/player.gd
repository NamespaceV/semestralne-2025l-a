class_name Player
extends CharacterBody2D


signal health_changed


@export var animation_tree : AnimationTree
@export var speed : float = 50.0
@export var max_health = 30


var current_health : int = max_health
var is_dead : bool = false


var input_vector
var mouse_vector
var playback : AnimationNodeStateMachinePlayback


func _ready():
	playback = animation_tree["parameters/playback"]


func _physics_process(delta: float) -> void:
	if current_health <= 0:
		is_dead = true
		$HUD/GameOver.visible = true
	else:
		input_vector = Input.get_vector("left", "right", "up", "down")
		mouse_vector = Vector2.ZERO.direction_to(get_local_mouse_position())
		velocity = input_vector * speed
		move_and_slide()
		select_animation()
		update_animation_parameters()


func select_animation():
	if velocity == Vector2.ZERO:
		playback.travel("Idle")
	else:
		playback.travel("Walk")


func update_animation_parameters():
	if input_vector == Vector2.ZERO and mouse_vector == Vector2.ZERO:
		return

	animation_tree["parameters/Idle/blend_position"] = mouse_vector
	animation_tree["parameters/Walk/blend_position"] = mouse_vector


func take_damage(damage: int, _caused_by: Node2D) -> void:
	current_health -= damage
	health_changed.emit()


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://test/noome/ui/menu/main_menu.tscn")
