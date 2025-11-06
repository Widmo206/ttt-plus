extends Node2D


var Piece = preload("res://piece.tscn")
var board = {}
var points = {
	true: 0,
	false: 0,
}
var current_player = false


signal point_gained(player: bool)
signal turn_started(player: bool)


var directions = [
	Vector2(0, 1),
	Vector2(1, 1),
	Vector2(1, 0),
	Vector2(1, -1)
	]

var colors = {
	true: Color(1.000, 0.490, 0.000),
	false: Color(0.204, 0.478, 0.816),
}

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("play"):
		var pos = get_global_mouse_position()
		var tile_pos = floor(pos / 32)
		
		if tile_pos in board.keys():
			# print("tile %v is occupied" % tile_pos)
			pass
			
		else:
			create_new_piece(tile_pos, current_player)
			
			for direction in directions:
				var win = find_win(direction, current_player, tile_pos)
				
				if win != []:
					points[current_player] += 1
					emit_signal("point_gained", current_player)
					
					var line = Line2D.new()
					for piece in win:
						# update state of relevant pieces
						board[piece].blocked_directions.append(direction)
						line.add_point(piece*32 + Vector2(16, 16))
						line.default_color = colors[current_player]
					
					add_child(line)
	
					
			
			current_player = !current_player
			emit_signal("turn_started", current_player)


func create_new_piece(tile_pos: Vector2, player: bool):
	var new_piece = Piece.instantiate()
	new_piece.set_player(int(player))
	new_piece.blocked_directions = []
	
	add_child(new_piece)
	new_piece.position = tile_pos*32 + Vector2(16, 16)
	board[tile_pos] = new_piece


func find_win(direction: Vector2, player: bool, last_move: Vector2) -> Array:
	var reversed = false
	var pieces = [last_move]
	var current_pos = Vector2(last_move) # I think that creates a new instance
	
	while len(pieces) < 5:
		if reversed:
			current_pos -= direction
		else:
			current_pos += direction
		
		
		if (current_pos in board.keys()
		and board[current_pos].player == int(current_player)
		and direction not in board[current_pos].blocked_directions
		):
			if current_pos not in pieces:
				# not bundled with other conditions
				# because it's just here to prevent miscounting
				pieces.append(current_pos)
		else:
			if reversed:
				# tried both sides, no win found
				#print("no win found for direction %v" % direction)
				#print("pieces found: ", pieces)
				return []
			else:
				# reached end, try other side
				reversed = true
				continue
	
	print(pieces)
	return pieces
