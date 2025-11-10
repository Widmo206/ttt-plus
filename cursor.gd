extends Node2D


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	position = floor((mouse_pos + Vector2(16, 16)) / 32) * 32


func _on_turn_started(player: bool) -> void:
	$Piece.set_player(player)
