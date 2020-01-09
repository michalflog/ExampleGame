extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var platforms_min_gap = 50
export var platforms_max_gap = 190
export (PackedScene) var Player
export (PackedScene) var Platform
export (PackedScene) var MovingPlatform
export (PackedScene) var CrackingPlatform
export (PackedScene) var MovingCrackingPlatform

var screen_size
var start_camera_position

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	screen_size = get_viewport_rect().size
	
	$HUD.connect("start_game", $".", "_on_start_game")
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $".".has_node("Player"):
		if $Player.position.y < $Camera2D.position.y:
			$Camera2D.position.y = $Player.position.y
			update_score(int(start_camera_position - $Camera2D.position.y) / 100)
			
		if $Player.position.y - $Camera2D.position.y > screen_size.y:
			$Player.queue_free()
			show_hud()
			
		var platforms = get_tree().get_nodes_in_group("platform")
		var highest_platform_y = platforms[0].position.y
		for x in platforms:
			if x.position.y < highest_platform_y:
				highest_platform_y = x.position.y
				
			if x.position.y > $Camera2D.position.y + screen_size.y/2 + 50:
				x.queue_free()
		
		if $Camera2D.position.y - highest_platform_y < screen_size.y:
			add_platform()
		pass
	pass
	
func add_platform():
	var posY = screen_size.y
	var platforms = get_tree().get_nodes_in_group("platform")
	
	for x in platforms:
		if x.position.y < posY:
			posY = x.position.y
	
	var plat_num = randi() % 4
	var platform
	if plat_num == 0:
		platform = Platform.instance()
	elif plat_num == 1:
		platform = MovingPlatform.instance()
	elif plat_num == 2:
		platform = CrackingPlatform.instance()
	elif plat_num == 3:
		platform = MovingCrackingPlatform.instance()
	
	platform.position.x = rand_range(50, screen_size.x - 50)
	platform.position.y = posY - rand_range(platforms_min_gap, platforms_max_gap)
	
	add_child(platform)
	
	pass
	
func _on_start_game():
	update_score(0)
	
	var platforms = get_tree().get_nodes_in_group("platform")
	for x in platforms:
		x.queue_free()
		
	var platform = Platform.instance()
	platform.position.x = screen_size.x/2
	platform.position.y = screen_size.y/2 + 100
	add_child(platform)
	
	var player = Player.instance()
	player.position.x = screen_size.x/2
	player.position.y = screen_size.y/2
	add_child(player)
	
	$Camera2D.position.x = 350
	$Camera2D.position.y = $Player.position.y
	
	start_camera_position = $Camera2D.position.y
	
	print_debug($Camera2D.position.x)
	
	pass
	
func show_hud():
	$HUD/Button.show()
	$HUD/MesegeLabel.show()
	$HUD/MesegeLabel.text = "You fallen"
	pass
	
func update_score(var score):
	$HUD/ScoreLabel.text = String(score)
	pass
