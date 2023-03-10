extends KinematicBody


var kil_part = preload("res://PlayerStuff/juice.tscn")
var pile = preload("res://PlayerStuff/ded.tscn")
var input
var speed = 10
var velocity = Vector3.ZERO
var target_velocity = Vector3.ZERO
var damage = 1
var max_health = 255
var health = max_health
var dash_strength = 0
var rev_step = 1
var step_time = 0.8
var step_timer = 0
var inv_time = 1
var inv_timer = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$HurtIndication.color = Color(173, 2, 2, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera/weapon/AttackArea/CPUParticles.set_emitting(false)
	step_timer = clamp(step_timer - delta, 0, step_time)
	inv_timer = clamp(inv_timer - delta, 0, inv_time)
	
	if Input.get_action_strength("ui_accept"):
		speed = 30
	else:
		speed = 10
	input = Vector3(Input.get_axis("ui_left", "ui_right"), -0.1, Input.get_axis("ui_up", "ui_down"))
	if input != Vector3(0, -0.1, 0) and step_timer <= 0:
		$stepSound.play()
		step_timer = step_time
	target_velocity = target_velocity.move_toward(input * speed, delta * 55)
	velocity = target_velocity.rotated(Vector3.UP, $Camera.rotation.y)
	move_and_slide(velocity)
	if $Camera.speening:
		if rev_step == 1:
			$weedWhackerAttack.play()
			rev_step = 2
		if not $weedWhackerAttack.playing and rev_step == 2:
			$weedWhackerSustain.play()
			rev_step = 3
		if $Camera/weapon/AttackArea.get_overlapping_bodies().empty():
			$weedWhackerSustain.pitch_scale = move_toward($weedWhackerSustain.pitch_scale, 1, delta)
		for enemy in $Camera/weapon/AttackArea.get_overlapping_bodies():
			if enemy.get("health") != null:
				$weedWhackerSustain.pitch_scale = move_toward($weedWhackerSustain.pitch_scale, 0.8, delta)
				$Camera/weapon/AttackArea/CPUParticles.set_emitting(true)
				enemy.health -= delta * damage
				if enemy.health <= 0:
					var temp = kil_part.instance()
					get_tree().get_root().add_child(temp)
					temp.global_transform.origin = enemy.global_transform.origin
					temp = pile.instance()
					get_tree().get_root().add_child(temp)
					temp.global_transform.origin = enemy.global_transform.origin
					enemy.call_deferred("queue_free")
					health = clamp(health + 50, 0, max_health)
					$HurtIndication.color = Color8(173, 2, 2, (255 - health))
					$kild.play()
	else:
		if rev_step == 3 or rev_step == 2:
			$weedWhackerSustain.stop()
			$weedWhackerRelease.play()
			rev_step = 1
		if not $weedWhackerIdle.playing:
			$weedWhackerAttack.stop()
			$weedWhackerIdle.play()

func hit(damage):
	if inv_timer <= 0:
		$hurted.play()
		health -= damage
		target_velocity -= Vector3(0, 0, -30)
		$HurtIndication.color = Color8(173, 2, 2, (255 - health))
		inv_timer = inv_time
		if health < 0:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().get_root().get_node("MusicManager").play_song = "death"
			get_tree().change_scene("res://DavidsStash/DeathScreen.tscn")


func _on_weedWhackerSustain_finished():
	if rev_step == 2 or rev_step == 3:
		$weedWhackerSustain.play()
