extends Area2D


var is_inside = false
@export var tick_damage = 1
@export var damage_taken = 2

func _on_body_entered(body: Node2D) -> void:
	var player = body as Player
	is_inside = true
	if player:
		while is_inside and not player.is_dead:
			await get_tree().create_timer(tick_damage).timeout
			player.take_damage(damage_taken, self)


func _on_body_exited(body: Node2D) -> void:
	var player = body as Player
	if player:
		is_inside = false
