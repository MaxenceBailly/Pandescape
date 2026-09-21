extends Node2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("set_player_on_bamboo"):
		body.set_player_on_bamboo(true)
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("set_player_on_bamboo"):
		body.set_player_on_bamboo(false)
