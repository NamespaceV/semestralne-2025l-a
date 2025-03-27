extends CharacterBody2D

var speed := 300.0
var rotation_speed := PI / 2 # per second
var attack_distance := -100.0


var attack_scene = load("res://test/zephyr/attack.tscn")

func _physics_process(delta: float) -> void:

	if Input.is_action_pressed("left"):
		rotate(-1 * delta * rotation_speed)
	if Input.is_action_pressed("right"):
		rotate(delta * rotation_speed)

	var new_velocity = 0
	if Input.is_action_pressed("up"):
		new_velocity += -1 * speed
	if Input.is_action_pressed("down"):
		new_velocity += speed

	velocity = new_velocity * transform.y
	move_and_slide()

	if Input.is_action_just_pressed("action"):
		var attack = attack_scene.instantiate()
		attack.name = "Attack"
		attack.position = global_position + attack_distance * transform.y
		get_tree().current_scene.add_child(attack, true)
