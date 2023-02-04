extends KinematicBody



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 10
var input
var velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	

	input = Vector3(Input.get_axis("ui_left", "ui_right"), 0, Input.get_axis("ui_up", "ui_down"))
	velocity = velocity.move_toward(input * speed, delta * 25)
	move_and_slide(velocity)

	
