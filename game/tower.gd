extends CharacterBody2D

var hp = 10
const fireball = preload("res://game/fireball.tscn")

var taking_damage = false

signal took_damage(hp)
signal died

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Backspace"):
		if $AnimationPlayer.current_animation == "savestreak" and Global.streak > 0:
			save_streak()
		
	
	if event is InputEventKey and event.pressed:
		# Get the unicode value of the key event
		var unicode_value = event.unicode
		
		# Check if the key has a valid unicode character
		if unicode_value != 0:
			# Convert the unicode value to a string
			var key_char = char(unicode_value)
			fire_fireball(key_char)
		else:
			pass
			# Handle keys that don't map to characters (like function keys, etc.)
			#print("Key pressed but no character representation: ", event.unicode)
			
func fire_fireball(chr):
	var enemy_list = get_parent().get_node("Enemies")
	for enemy:Enemy in enemy_list.get_children():
		if enemy.active and enemy.chr == chr:
			var f = fireball.instantiate()
			f.target = enemy
			f.target_char = enemy.chr
			get_parent().add_child(f)
			f.global_position = global_position
			f.velocity = Vector2(1,0).rotated(randf() * 2 * PI) * 600
			$FireFireball.play()
			return
	if Global.streak > 0:
		$AnimationPlayer.play("savestreak")
			
func save_streak():
	$AnimationPlayer.pause()
	$Control/VBoxContainer/Label.text = "←"
	$SaveSuccess.play()
	get_tree().create_timer(0.3).timeout.connect(func():$AnimationPlayer.play("RESET"))
	
func fail_save_streak():
	Global.streak = 0
	
	

func _on_area_2d_body_entered(body: Enemy) -> void:
	if taking_damage: return
	taking_damage = true
	body.remove()
	hp -= 1
	Global.streak = 0
	
	if hp <= 0:
		took_damage.emit(0)
		died.emit()
	else:
		$TakeDamage.play()
		took_damage.emit(hp)
	
	(func():taking_damage = false).call_deferred()
	#f.call_deferred()
