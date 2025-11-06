extends Node2D


enum Player {circle, cross}
var sprites = ["circle", "cross"]

var blocked_directions: Array
var player = Player.circle


func set_player(new_player: Player):
	player = new_player
	update_animation()


func update_animation() -> void:
	$Sprite.animation = sprites[player]


func _ready() -> void:
	update_animation()


func _process(delta: float) -> void:
	pass
