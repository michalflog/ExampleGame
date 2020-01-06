extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var platforms_min_gap = 50
export var platforms_max_gap = 190
export (PackedScene) var Platform
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$Camera2D.position.x = screen_size.x/2
	$Camera2D.position.y = $Player.position.y
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if $Player.position.y < $Camera2D.position.y:
		$Camera2D.position.y = $Player.position.y
		
	var platforms = get_tree().get_nodes_in_group("platform")
	var highest_platform_y = platforms[0].position.y
	for x in platforms:
		
		if x.position.y < highest_platform_y:
			highest_platform_y = x.position.y
			
		if x.position.y > $Camera2D.position.y + screen_size.y/2:
			x.free()
	
	if highest_platform_y - $Camera2D.position.y < screen_size.y:
		add_platform()
	pass
	
func add_platform():
	var posY = screen_size.y
	var platforms = get_tree().get_nodes_in_group("platform")
	
	for x in platforms:
		if x.position.y < posY:
			posY = x.position.y
			
	var platform = Platform.instance()
	
	platform.name = "Platform"
	platform.position.x = rand_range(50, screen_size.x - 50)
	platform.position.y = posY - rand_range(platforms_min_gap, platforms_max_gap)
	
	add_child(platform)
	
	pass
	
func restart_Game():
	pass
