extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var frank = false

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var randNum = rng.randi_range(0,1)
	if(randNum == 1):
		frank = true
		$mesh.material_override()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
