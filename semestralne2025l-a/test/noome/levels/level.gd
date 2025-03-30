extends TileMapLayer

class_name Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _connect_hot(node):
	node.area_entered.connect(_on_hot_entered)
	node.area_exited.connect(_on_hot_exited)


func _on_hot_entered():
	pass


func _on_hot_exited():
	pass
