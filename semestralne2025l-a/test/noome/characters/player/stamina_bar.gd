extends TextureProgressBar


@export var player: Player


func _ready() -> void:
	player.stamina_changed.connect(update)
	update()

func update():
	value = player.current_stamina * 100 / player.max_stamina
