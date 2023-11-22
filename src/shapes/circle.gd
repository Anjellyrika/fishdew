extends Node2D

var start_position = Vector2(574,505)

func _draw():
	draw_set_transform(start_position, 0, Vector2(1.25,0.5))
	draw_circle(Vector2.ZERO,20.0,Color("6DDFFF"))
