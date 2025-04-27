extends CharacterBody2D
class_name PlayerPICON

const speed = 100.0

func  get_input():
	var input_direction = Input.get_vector("left","right","up", "down")
	velocity = input_direction * speed

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	get_input()
	move_and_slide()
