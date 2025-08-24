extends Node2D

# How fast (pixels per second) it should go:
var speed := -300.0

# Which direction to move in; for example, to the right:
var direction := Vector2(1, 0)

func _process(delta: float) -> void:
	# Ensure the direction is normalized (unit length), 
	# then move at 'speed' pixels/sec:
	position += direction.normalized() * speed * delta
	
