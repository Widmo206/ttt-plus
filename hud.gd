extends CanvasLayer


var points = {
	true: 0,
	false: 0,
}
var colors = {
	true: Color(1.000, 0.490, 0.000),
	false: Color(0.204, 0.478, 0.816),
}

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_point_gained(player: bool) -> void:
	points[player] += 1
