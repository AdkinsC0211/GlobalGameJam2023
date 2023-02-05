extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




<<<<<<< HEAD
func _on_PlayAgainButton_pressed():
	get_tree().change_scene("res://MainMap.tscn")



func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://DavidsStash/TitleSceen.tscn")
=======

func _on_PlayButton_pressed():
	get_tree().change_scene("res://MainMap.tscn")
	get_tree().get_root().get_node("MusicManager").play_song = "game"
>>>>>>> c65d46aa6fbc77c295be739cf3c6bf3077306a6e
	



<<<<<<< HEAD
func _on_QuitButtonButton_pressed():
	get_tree().quit()
=======
func _on_QuitButton_pressed():
	get_tree().quit()
	
	


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://DavidsStash/TitleScreen2.tscn")
	get_tree().get_root().get_node("MusicManager").play_song = "menu"
>>>>>>> c65d46aa6fbc77c295be739cf3c6bf3077306a6e
