extends CharacterBody2D

# --- Exported variables you can tweak in the editor ---
@export var max_charge_time: float = 1.5           # Max time (in seconds) the player can hold charge
@export var max_leap_force: float = 1200.0         # Max leap speed when fully charged
@export var min_leap_force: float = 300.0          # Min leap speed (quick tap)
@export var drag: float = 600.0                    # Slows player down over time
@export var bounce_factor: float = 0.8             # How much speed is kept after bouncing (0 = no bounce, 1 = perfect bounce)

# --- Internal state variables ---
var is_charging := false                           # True when the player is holding the action key
var charge_timer := 0.0                            # How long the key has been held

func _process(delta: float) -> void:
	# Rotate the player to always face the mouse
	rotation = (get_global_mouse_position() - global_position).angle()

	# Start charging when the action key is pressed
	if Input.is_action_just_pressed("action"):
		is_charging = true
		charge_timer = 0.0

	# While charging, increase the charge timer
	if is_charging:
		charge_timer += delta
		charge_timer = clamp(charge_timer, 0.0, max_charge_time)

	# When the key is released, perform the leap
	if Input.is_action_just_released("action") and is_charging:
		is_charging = false
		perform_leap()

func perform_leap() -> void:
	# Calculate how strong the jump should be based on charge time
	var charge_ratio = charge_timer / max_charge_time
	var force = lerp(min_leap_force, max_leap_force, charge_ratio)

	# Calculate direction from player to mouse
	var mouse_dir = (get_global_mouse_position() - global_position).normalized()

	# Apply force in that direction
	velocity = mouse_dir * force

func _physics_process(delta: float) -> void:
	# Apply drag to gradually slow down the player
	if velocity.length() > 0:
		var drag_force = velocity.normalized() * drag * delta
		if drag_force.length() > velocity.length():
			velocity = Vector2.ZERO  # Stop completely if drag is stronger than current speed
		else:
			velocity -= drag_force   # Otherwise, reduce speed

	# Save current velocity before moving (used for bounce)
	var pre_move_velocity = velocity

	# Move the character and detect collisions
	move_and_slide()

	# Check for collisions and bounce off walls
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision and pre_move_velocity.dot(collision.get_normal()) < 0.0:
			# Bounce only if we're hitting the wall (not sliding along)
			velocity = pre_move_velocity.bounce(collision.get_normal()) * bounce_factor
			break  # Only bounce once per frame
