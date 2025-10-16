extends Node2D


enum Type {circle, cross}
var sprites = ["circle", "cross"]


var type = Type.circle


func set_type(new_type: Type):
	type = new_type
	update_animation()


func update_animation() -> void:
	$Sprite.animation = sprites[type]


func _ready() -> void:
	update_animation()


func _process(delta: float) -> void:
	pass
