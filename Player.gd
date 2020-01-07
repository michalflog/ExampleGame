extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 10
export var max_speed = 500
export var speed_decreas = 0.1
export var bounce_val = 500
export var gravity_val = 10
var screen_size

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position.x = screen_size.x/2
	position.y = screen_size.y/2
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if Input.is_action_pressed("ui_left"):
		if velocity.x > 0:
			velocity.x -= velocity.x * speed_decreas
		velocity.x -= speed
	elif Input.is_action_pressed("ui_right"):
		if velocity.x < 0:
			velocity.x -= velocity.x * speed_decreas
		velocity.x += speed
	else:
		velocity.x -= velocity.x * speed_decreas
		
	if position.x < 0:
		position.x = screen_size.x
	elif position.x > screen_size.x:
		position.x = 0
		
	velocity.y += gravity_val
		
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	
		
	position.x += velocity.x * delta
	position.y += velocity.y * delta
		
	pass
	
func _platform_enter(area):
	if area.is_in_group("platform"):
		if velocity.y >= 0: 
			velocity.y = -bounce_val
