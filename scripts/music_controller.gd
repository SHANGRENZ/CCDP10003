extends AudioStreamPlayer

var map_info
var enemy_instance
var note_index
var note_len
var move_speed

@onready var timer: Timer = $Timer
@onready var enemy = preload("res://scenes/enemy.tscn")

func _ready() -> void:
	map_info = load_json("res://maps/test.json")
	timer.wait_time = 60 / map_info["bpm"]
	timer.start()
	note_index = 0
	note_len = len(map_info["map"])
	self.stream = load(map_info["song"])
	
	# wait for some time
	move_speed = 4 * map_info["bpm"]
	await get_tree().create_timer(450 / move_speed).timeout
	
	self.play()

func load_json(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null: push_error("Could not open map file: \"", file_path, '"')
	
	var data = JSON.parse_string(file.get_as_text())
	if data == null: push_error("Invalid JSON in file: \"", file_path, '"')
	return data

func spawn_enemy(position):
	var vec
	var direction
	if position == 0:
		return
	elif position == 1:
		vec = Vector2(500, 0)
		direction = Vector2(-1, 0)
	elif position == 2:
		vec = Vector2(0, 500)
		direction = Vector2(0, -1)
	elif position == 3:
		vec = Vector2(-500, 0)
		direction = Vector2(1, 0)
	elif position == 4:
		vec = Vector2(0, -500)
		direction = Vector2(0, 1)
	
	enemy_instance = enemy.instantiate()
	get_tree().root.add_child(enemy_instance)
	enemy_instance.position = vec
	enemy_instance.direction = direction
	enemy_instance.speed = move_speed
	
func _on_timer_timeout() -> void:
	if note_index >= note_len:
		timer.stop()
		return
		
	spawn_enemy(map_info["map"][note_index])
	note_index += 1
