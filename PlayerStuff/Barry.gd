extends KinematicBody


# Declare member variables here. Examples:
var target = null
var speed = 20
var move_vec = Vector3.ZERO
onready var player = get_tree().get_nodes_in_group("player")[0]
var eating = preload("res://PlayerStuff/BarryFeast.tres")
var neutral = preload("res://PlayerStuff/Barry.tres")
var not_eating = true


# Called when the node enters the scene tree for the first time.
func _ready():
	target = player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target==player:
		if (target.transform.origin - transform.origin).length() < 10:
			speed = 0
		else:
			speed = 20
	if is_instance_valid(target):
		if not_eating:
			move_vec = (target.transform.origin - transform.origin).normalized()
			$MeshInstance.set_surface_material(0, neutral)
		if target.is_in_group("dead") and (target.transform.origin - transform.origin).length() < 5:
			print("somethinghappened!")
			$MeshInstance.set_surface_material(0, eating)
			target.queue_free()
			target = player
			$feast.start(5)
			move_vec = Vector3.ZERO
			not_eating = false
	else:
		target = player
	move_and_slide(move_vec * speed)


func _on_detection_body_entered(body):
	if body.is_in_group("dead"):
		target = body


func _on_feast_timeout():
	not_eating = true
