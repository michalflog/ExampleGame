extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var min_move_speed = 20
export var max_move_speed = 200

var direction = 1
var move_speed
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	move_speed = rand_range(min_move_speed, max_move_speed)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += direction * move_speed * delta
	if position.x > screen_size.x:
		direction = -1
	elif position.x < 0:
		direction = 1
	pass
