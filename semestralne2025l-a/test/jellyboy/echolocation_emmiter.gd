# EcholocationEmitter2D.gd
extends Node2D

@export var num_rays := 8
@export var ray_length := 300.0
@export var trail_step := 5.0
@export var max_bounces := 2
@export var trail_scene: PackedScene

func _process(delta: float):
	emit_echolocation()

func emit_echolocation():
	for i in num_rays:
		var angle = i * TAU / num_rays
		var dir = Vector2(cos(angle), sin(angle)).normalized()
		spawn_echo_ray(global_position, dir, max_bounces)

func spawn_echo_ray(origin: Vector2, direction: Vector2, bounces: int):
	var current_pos = origin
	var dir = direction
	var remaining_bounces = bounces
	var space = get_world_2d().direct_space_state

	while remaining_bounces >= 0:
		var params := PhysicsRayQueryParameters2D.create(current_pos, current_pos + dir * ray_length)
		params.exclude = [self]

		var result = space.intersect_ray(params)
		var end_pos = result.position if result else current_pos + dir * ray_length

		# Place trail rectangles
		var distance = current_pos.distance_to(end_pos)
		var steps = int(distance / trail_step)
		for s in steps:
			var t = float(s) / steps
			var pos = current_pos.lerp(end_pos, t)
			spawn_trail_rect(pos)

		if result:
			dir = dir.bounce(result.normal)
			current_pos = end_pos
			remaining_bounces -= 1
		else:
			break


func spawn_trail_rect(world_pos: Vector2):
	var rect = trail_scene.instantiate()
	rect.position = $Trail.to_local(world_pos)
	$Trail.add_child(rect)
