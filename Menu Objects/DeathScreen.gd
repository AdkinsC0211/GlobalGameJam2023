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


func _on_Play_Again_pressed():
	get_tree().change_scene("res://PlayerSpawnTest.tscn")


func _on_Main_Menu_pressed():
	get_tree().change_scene("res://TitleSceen.tscn")
	
	


func _on_Quit_Game_pressed():
	get_tree().quit()
