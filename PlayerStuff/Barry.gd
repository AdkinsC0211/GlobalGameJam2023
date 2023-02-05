extends KinematicBody


# Declare member variables here. Examples:
var target = null
var speed = 20
var move_vec = null
onready var player = get_tree().get_nodes_in_group("player")[0]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target == null:
		target = player
	if target==player:
		if (target.transform.origin - transform.origin).length() < 10:
			speed = 0
		else:
			speed = 20
	move_vec = (target.transform.origin - transform.origin).normalized()
	move_and_slide(move_vec * speed)
