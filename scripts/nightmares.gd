extends Node2D

const PROGRESS_SPEED: float = 100.0

func _process(delta: float) -> void:
	position.x += delta*PROGRESS_SPEED
