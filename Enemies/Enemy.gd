extends KinematicBody


var speed;



var target
var direction
var velocity

var rng = RandomNumberGenerator.new()

var isFrank = false
var frankMat

var health = null

var small = false
var medium = false
var big = false

var player
var playerLoc
var playerInRange = false

const SMALL_SPEED = 8
const MED_SPEED = 5
const BIG_SPEED = 3

const SMALL_STRENGTH = 10
const MED_STRENGTH = 20
const BIG_STRENGTH = 30

const SMALL_MAX_HEALTH = 1
const MED_MAX_HEALTH = 2
const BIG_MAX_HEALTH = 4

const JUMP_HEIGHT = 5
const JUMP_DURATION = 1

const GRAVITY = -10

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	if is_in_group("small"):
		small = true
		speed = SMALL_SPEED
		health = SMALL_MAX_HEALTH
		frankMat = preload("res://Enemies/frank.tres")
		var randNum = rng.randi_range(0,1)
		if randNum == 1:
			isFrank = true
			$mesh.set_material_override(frankMat)
			speed /= 2
			
	elif is_in_group("medium"):
		medium = true
		speed = MED_SPEED
		health = MED_MAX_HEALTH
		
	elif is_in_group("big"):
		big = true
		speed = BIG_SPEED
		health = BIG_MAX_HEALTH
	
	player = get_tree().get_nodes_in_group("player")[0]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(playerInRange):
		if(small):
			player.hit(SMALL_STRENGTH)
		if(medium):
			player.hit(MED_STRENGTH)
		if(big):
			player.hit(BIG_STRENGTH)
	
	target = Vector3(player.translation.x, 0, player.translation.z)
	direction = (target-translation).normalized() 
	setVelocityBasedOnAction()
	move_and_slide(velocity)
	
func setVelocityBasedOnAction():
	velocity = Vector3(direction.x * speed, GRAVITY, direction.z * speed) #Normal Moving


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		playerInRange = true


func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		playerInRange = false
