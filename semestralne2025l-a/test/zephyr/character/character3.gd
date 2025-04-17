extends CharacterBody2D

var speed := 600.0
var rotation_speed := 3 * PI / 2 # per second
var attack_distance := -100.0


var attack_scene = load("res://test/zephyr/attack.tscn")

func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("action"):
		var attack = attack_scene.instantiate()
		attack.name = "Attack"
		attack.position = global_position + transform.x * 200
		get_tree().current_scene.add_child(attack, true)

	var target = get_global_mouse_position()
	var angle = get_angle_to(target)
	var rotation_angle = delta * rotation_speed
	if abs(angle) <= rotation_angle:
		rotate(angle)
	else:
		rotate(rotation_angle * sign(angle))
	var new_velocity = 0
	if Input.is_action_pressed("up"):
		new_velocity += 1 * speed
		velocity = new_velocity * transform.x
		move_and_slide()
	if Input.is_action_pressed("down"):
		new_velocity -= 1 * speed
		velocity = new_velocity * transform.x
		move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://test/zephyr/movement.tscn")
