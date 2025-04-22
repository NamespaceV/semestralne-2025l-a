extends CharacterBody2D


const speed = 100.0

func  get_input():
	var input_direction = Input.get_vector("left","right","up", "down")
	velocity = input_direction * speed

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotate(PI/2)
	get_input()
	move_and_slide()
