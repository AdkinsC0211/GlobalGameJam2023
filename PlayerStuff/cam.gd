extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouse_sensitivity = 0.2
var delt = 0
var speen = 0
var speening = false
var lift = -30


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta):
	$weapon.global_rotation.x = move_toward($weapon.global_rotation.x, deg2rad(lift), delta * 5)
	if not speening:
		speen -= delt * 100
		if speen < 0:
			speen = 0
	$weapon.get_node("wack").rotate_z(speen * delta)
	delt = delta
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -30, 50)
			
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0, 360)
		rotation_degrees.x = clamp(rotation_degrees.x, -30, 50)
			
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0, 360)
	elif event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			speening = true
			speen = 50
			lift = -10
		elif event.button_index == BUTTON_LEFT:
			speening = false
			lift = -35
		elif event.button_index == BUTTON_RIGHT and event.pressed:
			speening = true
			speen = 50
			lift = -60
		elif event.button_index == BUTTON_RIGHT:
			speening = false
			lift = -35
