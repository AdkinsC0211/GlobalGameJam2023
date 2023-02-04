extends Label3D




# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	_display()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _display():
	var EnemyHealth = get_parent().HealthRemaining
	self.set_text(str(EnemyHealth))
