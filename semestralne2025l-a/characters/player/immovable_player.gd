extends CharacterBody2D
class_name ImmovablePlayerPICON

const speed = 0
var bullet_speed = 375
var bullet = preload("res://scenes/bullet.tscn")


func  get_input():
	var input_direction = Input.get_vector("left","right","up", "down")
	velocity = input_direction * speed


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	get_input()
	move_and_slide()


func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.linear_velocity = Vector2(bullet_speed, 0).rotated(rotation)
	get_tree().get_root().call_deferred("add_child", bullet_instance)
