class_name Bamboo
extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("add_bamboo_to_list"):
		body.add_bamboo_to_list(self)
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("remove_bamboo_from_list"):
		body.remove_bamboo_from_list(self)
