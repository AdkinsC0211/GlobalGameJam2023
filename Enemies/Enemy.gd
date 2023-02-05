extends KinematicBody


var speed;



var target
var direction
var velocity

var rng = RandomNumberGenerator.new()

var isFrank = false
var frankMat

var health = null
var weight

var small = false
var medium = false
var big = false

var player
var playerLoc
var playerInAttackRange = false
var playerInPounceRange = false

const SMALL_SPEED = 8
const MED_SPEED = 5
const BIG_SPEED = 3

const SMALL_STRENGTH = 10
const MED_STRENGTH = 20
const BIG_STRENGTH = 30

const SMALL_MAX_HEALTH = 1
const MED_MAX_HEALTH = 2
const BIG_MAX_HEALTH = 4

const JUMP_V_POWER_FRANK = 17
const JUMP_H_SPEED_FRANK = 3
const JUMP_DURATION_FRANK = 0.5

const JUMP_V_POWER_BOB = 20
const JUMP_H_SPEED_BOB = 3
const JUMP_DURATION_BOB = 0.1

const SMALL_WEIGHT = 1
const MED_WEIGHT = 5
const BIG_WEIGHT = 20


var isJumping = false
var timeLeftGround

const GRAVITY = -10
var isGrounded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	velocity = Vector3(0,0,0)
	if is_in_group("small"):
		small = true
		speed = SMALL_SPEED
		health = SMALL_MAX_HEALTH
		frankMat = preload("res://Enemies/frank.tres")
		var randNum = rng.randi_range(0,1)
		if randNum == 1:
			isFrank = true
			
		if isFrank:
			$mesh.set_material_override(frankMat)
			speed /= 2
		
		weight = SMALL_WEIGHT
	elif is_in_group("medium"):
		medium = true
		speed = MED_SPEED
		health = MED_MAX_HEALTH
		weight = MED_WEIGHT
		
	elif is_in_group("big"):
		big = true
		speed = BIG_SPEED
		health = BIG_MAX_HEALTH
		weight = BIG_WEIGHT
	
	player = get_tree().get_nodes_in_group("player")[0]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(playerInAttackRange):
		if(small):
			player.hit(SMALL_STRENGTH)
		if(medium):
			player.hit(MED_STRENGTH)
		if(big):
			player.hit(BIG_STRENGTH)
			
	if find_node("GroundCast") != null:
		if $GroundCast.is_colliding():
				isGrounded = true
		else:
			isGrounded = false
	
	target = Vector3(player.translation.x, 0, player.translation.z)
	direction = (target-translation).normalized() 
	setVelocityBasedOnAction()
	move_and_slide(velocity, Vector3.UP)
	
func setVelocityBasedOnAction():
	if (isFrank and playerInPounceRange and isGrounded): #Frank Jump
		if(!isJumping):
			timeLeftGround = Time.get_ticks_msec()
			isJumping = true
			velocity.y = GRAVITY + JUMP_V_POWER_FRANK
			velocity.x *= JUMP_H_SPEED_FRANK
			velocity.z *= JUMP_H_SPEED_FRANK
	elif (isFrank and isJumping): #Frank Fall
		if(((Time.get_ticks_msec()-timeLeftGround)/1000.0) >= JUMP_DURATION_FRANK):
			isJumping = false
	elif (big and isGrounded): #Bob JUmp
		if (!isJumping):
			timeLeftGround = Time.get_ticks_msec()
			isJumping = true
			velocity.y = GRAVITY + JUMP_V_POWER_BOB
			velocity.x *= JUMP_H_SPEED_BOB
			velocity.z *= JUMP_H_SPEED_BOB
	elif(big and isJumping):
		if(((Time.get_ticks_msec()-timeLeftGround)/1000.0) >= JUMP_DURATION_BOB):
			isJumping = false
	elif (!isJumping):
		velocity = Vector3(direction.x * speed, GRAVITY - weight, direction.z * speed) #Normal Moving


func _on_Hitbox_body_entered(body):
	if body.is_in_group("player"):
		playerInAttackRange = true


func _on_Hitbox_body_exited(body):
	if body.is_in_group("player"):
		playerInAttackRange = false


func _on_JumpDetection_body_entered(body):
	if body.is_in_group("player"):
		playerInPounceRange = true;


func _on_JumpDetection_body_exited(body):
	if body.is_in_group("player"):
		playerInPounceRange = false;
