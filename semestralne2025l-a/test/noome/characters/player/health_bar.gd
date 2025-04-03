extends TextureProgressBar


@export var player: Player


func _ready() -> void:
	player.health_changed.connect(update)
	update()

func update():
	value = player.current_health * 100 / player.max_health
