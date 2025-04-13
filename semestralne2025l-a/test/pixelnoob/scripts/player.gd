extends CharacterBody2D

const SPEED = 130.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down").normalized()

	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true

	if direction.x == 0 and direction.y == 0:
		animated_sprite.play("idle")
	elif direction.y > 0:
		animated_sprite.play("move_down")
	elif direction.y < 0:
		animated_sprite.play("move_up")
	else:
		animated_sprite.play("move_side")

	move_and_slide()
