extends RigidBody


var speed = 5
var jumpPower = 2

var rng = RandomNumberGenerator.new()
var isFrank = false
var frankMat

var player
var playerLoc

# Called when the node enters the scene tree for the first time.
func _ready():
	frankMat = preload("res://Enemies/frank.tres")
	rng.randomize()
	var randNum = rng.randi_range(0,1)
	if(randNum == 1):
		isFrank = true
		$mesh.set_material_override(frankMat)
		speed /= 2
	
	player = get_tree().get_nodes_in_group("player")[0]
	playerLoc = player.translation
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target = Vector3(playerLoc.x, translation.y, playerLoc.z)
	look_at(target, Vector3.UP)
	translate(Vector3.FORWARD * speed * delta)
	
