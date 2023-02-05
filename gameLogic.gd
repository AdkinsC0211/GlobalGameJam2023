extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var killCount = 0
var spawnLocs
var clearChecking = false
var rng = RandomNumberGenerator.new()
var waveCount = 0
var waveText
var canvas
var textTimer
var worldRoot
var waveTimer

onready var smallEnemy = preload("res://Enemies/SmallEnemy.tscn")
onready var mediumEnemy = preload("res://Enemies/MediumEnemy.tscn")
onready var bigEnemy = preload("res://Enemies/BigEnemy.tscn")

const ENEMY_INCREASE = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	spawnLocs = get_children()
	worldRoot = get_tree().get_root().get_node("Spatial")
	canvas = worldRoot.get_node("CanvasLayer")
	waveTimer = worldRoot.get_node("waveTimer")
	waveText = canvas.get_child(0)
	textTimer = canvas.get_child(1)
	
	newWave()


# Called every frame. 'delta' is the elapsed time since the previous frame.

func newWave():
	var spawnPoint
	var instance
	waveCount += 1
	waveText.show()
	waveText.set_text("Wave " + str(waveCount))
	textTimer.start()
	waveTimer.start()
	for i in range(waveCount * ENEMY_INCREASE):
		spawnPoint = spawnLocs[rng.randi_range(0,97)].transform.origin
		var enemyChoice = rng.randi_range(0,3)
		if enemyChoice == 0:
			instance = smallEnemy.instance()
		elif enemyChoice == 1:
			instance = smallEnemy.instance()
			instance.isFrank = true
		elif enemyChoice == 2:
			instance = mediumEnemy.instance()
		elif enemyChoice == 3:
			instance = bigEnemy.instance()
		add_child(instance)
		instance.transform.origin = spawnPoint
		
	clearChecking = true


func _on_TextTimer_timeout():
	waveText.hide()
	pass # Replace with function body.


func _on_waveTimer_timeout():
	newWave()
	pass # Replace with function body.
