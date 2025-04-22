class_name Player
extends CharacterBody2D


signal health_changed
signal stamina_changed


@export var animation_tree : AnimationTree
@export var speed : float = 50.0
@export var max_health = 30
@export var sprint_accel = 2
@export var max_stamina = 100

var current_stamina : int = max_stamina
var current_health : int = max_health
var is_dead : bool = false
var is_running : bool = false

var input_vector
var mouse_vector
var playback : AnimationNodeStateMachinePlayback


func _ready():
	playback = animation_tree["parameters/playback"]


func _physics_process(_delta: float) -> void:
	if current_health <= 0:
		is_dead = true
		$HUD/GameOver.visible = true
	else:
		input_vector = Input.get_vector("left", "right", "up", "down")
		mouse_vector = Vector2.ZERO.direction_to(get_local_mouse_position())
		velocity = input_vector * speed
		if Input.is_action_pressed("action") and current_stamina > 0:
			is_running = true
			velocity = velocity * sprint_accel
			if $HUD/StaminaBar/StaminaTick.is_stopped():
				$HUD/StaminaBar/StaminaTick.start()
		else:
			is_running = false
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


func _on_stamina_tick_timeout() -> void:
	if is_running:
		current_stamina -= 5
		stamina_changed.emit()
	elif current_stamina < max_stamina:
		current_stamina += 2
		stamina_changed.emit()
	else:
		$HUD/StaminaBar/StaminaTick.stop()
