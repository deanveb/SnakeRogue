extends CharacterBody2D

@onready var tile_map = $"../TileMap"
@onready var sprite_2d = $Sprite2D
var current_direction : Vector2
var is_moving : bool = false
var speed : float = 3

func _physics_process(delta):
	
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, speed)
func _process(delta) -> void:
	if Input.is_action_just_pressed("left"):
		if current_direction + Vector2.LEFT == Vector2(0, 0):
			return
		current_direction = Vector2.LEFT
	elif Input.is_action_just_pressed("right"):
		if current_direction + Vector2.RIGHT == Vector2(0, 0):
			return
		current_direction = Vector2.RIGHT
	elif Input.is_action_just_pressed("up"):
		if current_direction + Vector2.UP == Vector2(0, 0):
			return
		current_direction = Vector2.UP
	elif Input.is_action_just_pressed("down"):
		if current_direction + Vector2.DOWN == Vector2(0, 0):
			return
		current_direction = Vector2.DOWN
	

func move(direction : Vector2i) -> void:
	is_moving = true
	var current_tile : Vector2i= tile_map.local_to_map(global_position)
	var next_tile = current_tile + direction
	var tile_data : TileData = tile_map.get_cell_tile_data(0, next_tile)
	if !tile_data.get_custom_data("Walkable"):
		return
	global_position = tile_map.map_to_local(next_tile)
	sprite_2d.global_position = tile_map.map_to_local(current_tile)

func _on_walking_delay_timeout():
	move(current_direction)
