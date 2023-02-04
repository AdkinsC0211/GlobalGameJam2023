extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var input
var speed = 10
var velocity = Vector3.ZERO
var target_velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	input = Vector3(Input.get_axis("ui_left", "ui_right"), 0, Input.get_axis("ui_up", "ui_down"))
	target_velocity = target_velocity.move_toward(input * speed, delta * 55)
	velocity = target_velocity.rotated(Vector3.UP, $Camera.rotation.y)
	move_and_slide(velocity)
