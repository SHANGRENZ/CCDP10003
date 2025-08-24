extends Node2D

# How fast (pixels per second) it should go:
var speed

# Which direction to move
var direction

func _process(delta: float) -> void:
	# Ensure the direction is normalized (unit length), 
	# then move at 'speed' pixels/sec:
	position += direction.normalized() * speed * delta
	
