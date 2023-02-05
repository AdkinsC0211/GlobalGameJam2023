extends CPUParticles


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var once = true

# Called when the node enters the scene tree for the first time.
func _ready():
	set_emitting(true)
	$splat.set_emitting(true)
	$woood.set_emitting(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if once:
		set_emitting(true)
		$splat.set_emitting(true)
		$woood.set_emitting(true)
		once = false
	if not once and not is_emitting():
		queue_free()
