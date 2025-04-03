extends CharacterBody2D


@export var animation_tree : AnimationTree
@export var speed : float = 50.0


var input_vector
var mouse_vector
var playback : AnimationNodeStateMachinePlayback


func _ready():
	playback = animation_tree["parameters/playback"]


func _physics_process(delta: float) -> void:
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
