extends Node

signal switch_pressed ()

var player_touching
var switch_was_pressed

func _ready() -> void:
	$ActiveSwitch.color = Color.from_string("a61919", Color.RED)


func switch_is_active() -> bool:
	return not switch_was_pressed


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not switch_is_active():
		return
	if body is PlayerPICON:
		player_touching = true
		$ActiveSwitch.color = Color.from_string("19a629", Color.GREEN)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if not switch_is_active():
		return
	if body is PlayerPICON:
		player_touching = false
		$ActiveSwitch.color = Color.from_string("a61919", Color.RED)


func _unhandled_input(event: InputEvent) -> void:
	if not switch_is_active():
		return
	if event.is_action_pressed("action") and player_touching:
		switch_pressed.emit()
		switch_was_pressed = true
		$ActiveSwitch.hide()
		$PressedSwitch.show()
