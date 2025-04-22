extends CharacterBody2D

var speed := 300.0
var rotation_speed := PI / 2 # per second
var attack_distance := -100.0


var attack_scene = load("res://test/zephyr/character/attack.tscn")

func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("action"):
		var attack = attack_scene.instantiate()
		attack.name = "Attack"
		attack.position = get_global_mouse_position()
		get_tree().current_scene.add_child(attack, true)

	var new_velocity = 0
	if Input.is_action_pressed("action"):
		var target = get_global_mouse_position()
		var angle = get_angle_to(target)
		var rotation_angle = delta * rotation_speed
		if abs(angle) <= rotation_angle:
			rotate(angle)
			new_velocity += 1 * speed
		else:
			rotate(rotation_angle * sign(angle))

	velocity = new_velocity * transform.x
	move_and_slide()


func go_to_next_level():
	get_tree().change_scene_to_file("res://test/zephyr/movement3.tscn")


func _on_area_2d_body_entered(_body: Node2D) -> void:
	call_deferred("go_to_next_level")
