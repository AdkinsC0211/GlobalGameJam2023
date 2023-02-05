extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var play_song = "menu"
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if play_song == "menu":
		$game_theme.stop()
		$game_theme2.stop()
		$game_theme3.stop()
		$death_theme.stop()
		if not $menu_theme.playing:
			$menu_theme.play()
	elif play_song == "game":
		$menu_theme.stop()
		$death_theme.stop()
		if not $game_theme.playing and not $game_theme2.playing and not $game_theme3.playing:
			var temp = rng.randi() % 3
			if temp == 0:
				$game_theme.play()
			elif temp == 1:
				$game_theme2.play()
			elif temp == 2:
				$game_theme.play()
	elif play_song == "death":
		$game_theme.stop()
		$game_theme2.stop()
		$game_theme3.stop()
		$menu_theme.stop()
		if not $death_theme.playing:
			$death_theme.play()
