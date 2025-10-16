extends Node2D


var piece = preload("res://piece.tscn")
var pieces = {}
var current_player = false


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("play"):
		var pos = get_global_mouse_position()
		var tile_pos = floor(pos / 32)
		
		if tile_pos in pieces.keys():
			pass
		else:
			var new_piece = piece.instantiate()
			new_piece.set_type(current_player)
			add_child(new_piece)
			new_piece.position = tile_pos*32 + Vector2(16, 16)
			current_player = !current_player
